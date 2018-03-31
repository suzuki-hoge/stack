# モナド変換子でレイヤー設計
## 要点
+ 単体テスト
+ レイヤー設計
+ モナド変換子

## 要件
+ 動画サイト
+ ユーザを登録してある
+ プレミアムオプションを契約できる
  + 登録から１年経ってる
  + プレミアムオプションを持っていない
  + 紹介コードが有効である
+ 登録してある方法で通知する
  + SMS / メール
  + 内容は払い出されたオプション ID、宛先は電話番号かメールアドレス

## データ構造
+ ユーザ
  + ユーザ ID
  + 登録月
  + プレミアムオプション 0..1
    + オプション番号
  + 連絡先
    + 方法 SMS / メール
    + SMS の場合
      + 電話番号
    + メールの場合
      + メールアドレス
+ 紹介コード
  + プレミアムオプション紹介コード
  + 状態 未使用 / 使用済み
  
## レイヤー設計
今回は以下の様にしてみる

層         | 型                                           | エラー                         | 備考                                             
:--        | :--                                          | :--                                    | :--                                              
Api        | [(String, String)] -> IO [(String, String)]  | 全ての種類のエラーをハンドルしアウトパラにする |                                                  
Form       | Maybe String -> Validation ValidationError a | バリデーションエラーを発生させる                   | Api のサブレイヤー                               
Service    | a -> EitherT BusinessError IO b              | Domain と Repository のエラーを合成する          | Service を組み合わせやすい
Domain     | a -> Either BusinessError b                  | 業務エラーを発生させる                             | 副作用厳禁                                       
Repository | a -> IO b                                    | システムエラーを発生させる                         | Domain のサブレイヤー<br>今回は依存性の逆転は略  

エラーの階層構造はこんなイメージ

```
Api                            : handle all
|-- Form                     : Validation
`-- Service                : EitherT IO
    `-- Domain           : Either
        `-- Repository : IO
```

## システム入出力
### 入力
```
user-id-form: user-1, introduction-code-form: abc
```
+ `user-id`（`user-` + 数値）
+ `introduction-code`（３桁）

### 出力
+ 正常終了時
```
result: option-1
```
+ 業務エラー時
```
result: business-error,
message: already premium
```
+ システムエラー時
```
result: system-error,
message: no such user
```
+ バリデーションエラー時
```
result: validation-error,
message: [
  user-id-form must be starting user-,
  introduction-code-form must be 3 length
]
```

## モデルとレイヤー図
+ Haskell の単語で Java 風に書く
+ おおよそパッケージ名がファイル名
  + 感覚が掴めたので、次はもっとうまくやる

-> [image](./doc/image/model.png)

## テスト
+ `Domain`は単体テストを行う
  + 似た形になる分は１件だけ書いて省略
+ `Api`で全層結合した全エラーパターンのテストを行う

-> [image](./doc/image/test.png)

## 感想
+ `EitherT IO`をいつ使うか
  + `Domain`の副作用を無くすと、当然`IO`はなくなり`Either`のみになる
  + では`Repository`の戻りに`Either`を用いるか
    + `Left`に接続エラー等を入れるかどうかによる
    + `Either`の失敗はあくまで業務エラーにしたいのでそれは行わない
  + しかし、それらを両方用いる`Service`が存在するので、そこで`EitherT IO`が必要になる
+ `catch`が初見
  + `IO a -> (e -> IO a) -> IO a`なので、元々の戻りの型と同じものを返さなければならない模様
  + `runEitherT :: EitherT x m a -> m (Either x a)`なので、今回の文脈で`x <- runEitherT`すると`IO`剥がしになるので`catch`があう
  + ただし`catch`した後に`IO (Either BusinessError a)`を用意しなければならず、システム例外とは型が合わない
  + なので先に`IO [(String, String)]`になる様にラップして、それを`catch`してシステム例外の型と合わせる
+ 始めて IntelliJ で書けた
  + 有料の最新版を買ったおかげか
  + Java ほどの恩恵は受けられないが...体感としてジャンプできる箇所が Java の半分くらい
  + それでもないより良いし、なによりライブラリにジャンプして中が読めるのがとても良い
  + それで`hoistEither`とか見つけたのは良い感じ
+ 雑感
  + 演算子化はやはり言語的になって良い
  + モジュールの`export`方針がよく分からない
  + 属性名付けなくても`Entity (VO1 v1) (VO2 v2)`の形で案外事足りる
    + `value`が重複する問題は思い切ると案外平気
+ 次の課題
  + イケてる`catch`は最近だとこれとは違う模様
    + `MonadCatch`, `MonadIO`とは
  + `FreeMonad`
  + `stack`が全然わからん...
    + `stack`の出力に警告が異様に多い
    + `.cabal`に都度ファイル名足すの、ホント？
  + IntelliJ をまだちゃんと設定できてない感
  + 標準出力もテスト簡単にできるのかな？
    + あんまやる気はないけど、楽なら
  + 非同期
    + 通知と更新処理の箇所
