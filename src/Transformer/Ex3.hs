module Transformer.Ex3 where

import Transformer.Types


asMail :: To -> Subject -> Body -> Mail
asMail to sub body = "send to " ++ to ++ " [" ++ sub ++ "] " ++ body

sendMail :: Mail -> IO ()
sendMail = putStrLn

findHospital :: Address -> IO (Either Error Hospital)
findHospital address = return $ Right $ address ++ " hospital"

getHoliday :: Hospital -> IO (Either Error Holiday)
getHoliday hospital = return $ Right "wed"

getToday :: IO Today
getToday = return "mon"

asConclusion :: Holiday -> Today -> Hospital -> Conclusion
asConclusion holiday today hospital = case holiday == today of
  True -> "stay home"
  False -> "go " ++ hospital


ex3 :: IO (Either Error Conclusion)
ex3 = do
  let mail = asMail "office" "sorry" "I caught cold."
  sendMail mail

  hospital <- findHospital "tokyo"
  case hospital of
    Right(hospital') -> do
      holiday <- getHoliday hospital'
      case holiday of
        Right(holiday') -> do
          today <- getToday
          let conclusion = asConclusion holiday' today hospital'
          return $ Right conclusion
        Left(x) -> return $ Left x
    Left(x) -> return $ Left x
