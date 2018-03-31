module Layer.Api.OptionApiSpec where

import Test.Hspec

import Layer.Api.OptionApi


user1 = ("user-id-form", "user-1")
user2 = ("user-id-form", "user-2")
user3 = ("user-id-form", "user-3")
user4 = ("user-id-form", "user-4")
code1 = ("introduction-code-form", "abc")
code2 = ("introduction-code-form", "xyz")
code3 = ("introduction-code-form", "")

spec :: Spec
spec = do
  describe "invoke" $ do
    it "return option id if registered at 201702, no option, and unused introduction code" $ do
      show <$> (invoke $ Parameters [user1, code1]) `shouldReturn` "result: option-1"

    it "business error if registered at 201703, no option, and unused introduction code" $ do
      show <$> (invoke $ Parameters [user2, code1]) `shouldReturn` "result: business-error, message: not elapsed one year"

    it "business error if registered at 201702, HAVE option, and unused introduction code" $ do
      show <$> (invoke $ Parameters [user3, code1]) `shouldReturn` "result: business-error, message: already premium"

    it "business error if registered at 201702, no option, and USED introduction code" $ do
      show <$> (invoke $ Parameters [user1, code2]) `shouldReturn` "result: business-error, message: used introduction code"

    it "system error if nonexistent user" $ do
      show <$> (invoke $ Parameters [user4, code1]) `shouldReturn` "result: system-error, message: user error (no such user)"

    it "validation error when user id is missing and invalid introduction code" $ do
      show <$> (invoke $ Parameters [code3]) `shouldReturn` "result: validation-error, message: [user-id-form is required, introduction-code-form must be 3 length]"
