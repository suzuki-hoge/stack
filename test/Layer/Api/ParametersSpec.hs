module Layer.Api.ParametersSpec where

import Test.Hspec

import Layer.Api.Parameters


spec :: Spec
spec = do
  describe "parameters" $ do
    let parameters = Parameters [("user-id-form", "user-1")]
    it "test" $ do
      parameters !? "user-id-form" `shouldBe` Just "user-1"
      parameters !? "introduction-code-form" `shouldBe` Nothing
