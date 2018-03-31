module Layer.Domain.IntroductionSpec where

import Test.Hspec

import Layer.Domain.Introduction


spec :: Spec
spec = do
  describe "checkContractableCode" $ do
    it "not contractable if code is used" $ do
      checkContractableCode Used `shouldBe` Left "used introduction code"
    it "contractable if code is unused" $ do
      checkContractableCode Unused `shouldBe` Right ()
