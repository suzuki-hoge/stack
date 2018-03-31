module Layer.Api.Form (
  module Layer.Api.Form
, module Data.Validation
, module Layer.Api.Parameters
, module Layer.Api.ValidationErrors
) where

import Data.List(isPrefixOf)
import Data.Validation
import Layer.Api.Parameters
import Layer.Api.ValidationErrors
import Layer.Service.Application
import Layer.Domain.User
import Layer.Domain.Introduction


applicationForm :: Parameters -> Validation ValidationErrors Application
applicationForm ps = Application <$> userId <*> introductionCode
  where
    userId = userIdForm (ps !? "user-id-form")
    introductionCode = introductionCodeForm (ps !? "introduction-code-form")


userIdForm :: Maybe Value -> Validation ValidationErrors UserId
userIdForm value = case value of
  Just v
    | "user-" `isPrefixOf` v -> Success $ UserId v
    | otherwise              -> Failure ["user-id-form must be starting user-"]
  Nothing -> Failure ["user-id-form is required"]


introductionCodeForm :: Maybe Value -> Validation ValidationErrors IntroductionCode
introductionCodeForm value = case value of
  Just v
    | length v == 3 -> Success $ IntroductionCode v
    | otherwise     -> Failure ["introduction-code-form must be 3 length"]
  Nothing -> Failure ["introduction-code-form is required"]
