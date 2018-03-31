module Layer.Api.FormSpec where

import Test.Hspec

import Layer.Api.Parameters
import Layer.Api.Form
import Layer.Service.Application
import Layer.Domain.User
import Layer.Domain.Introduction


validUserId = UserId "user-1"
validIntroductionCode = IntroductionCode "abc"


spec :: Spec
spec = do
  describe "userIdForm" $ do
    it "empty" $ do
      userIdForm Nothing `shouldBe` Failure ["user-id-form is required"]

    it "invalid prefix" $ do
      userIdForm (Just "1") `shouldBe` Failure ["user-id-form must be starting user-"]

    it "valid" $ do
      userIdForm (Just "user-1") `shouldBe` Success validUserId

  describe "introductionCodeForm" $ do
    it "empty" $ do
      introductionCodeForm Nothing `shouldBe` Failure ["introduction-code-form is required"]

    it "invalid length" $ do
      introductionCodeForm (Just "a") `shouldBe` Failure ["introduction-code-form must be 3 length"]

    it "valid" $ do
      introductionCodeForm (Just "abc") `shouldBe` Success validIntroductionCode

  describe "applicationForm" $ do
    it "application construction failured if user id is missing" $ do
      applicationForm (Parameters [("introduction-code-form", "abc")]) `shouldBe` Failure ["user-id-form is required"]

    it "application construction failured if introduction code is invalid" $ do
      applicationForm (Parameters [("user-id-form", "user-1"), ("introduction-code-form", "a")]) `shouldBe` Failure ["introduction-code-form must be 3 length"]

    it "application construction succeed if user id is valid and introduction code is valid" $ do
      applicationForm (Parameters [("user-id-form", "user-1"), ("introduction-code-form", "abc")]) `shouldBe` Success (Application validUserId validIntroductionCode)

