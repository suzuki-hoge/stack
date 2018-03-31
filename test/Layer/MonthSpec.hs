module Layer.MonthSpec where

import Test.Hspec

import Layer.Month

spec :: Spec
spec = do
  describe "minus" $ do
    it "test" $ do
      (Month 201803) `minus` (Month 201803) `shouldBe` 0
      (Month 201803) `minus` (Month 201802) `shouldBe` 1
      (Month 201803) `minus` (Month 201703) `shouldBe` 12
      (Month 201803) `minus` (Month 201702) `shouldBe` 13
      (Month 201803) `minus` (Month 201704) `shouldBe` 11
