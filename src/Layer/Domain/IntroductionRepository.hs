module Layer.Domain.IntroductionRepository (
  module Layer.Domain.IntroductionRepository
, module Layer.Domain.Introduction
) where

import Control.Exception

import Layer.Domain.Introduction


findStatus :: IntroductionCode -> IO IntroductionCodeStatus
findStatus code = case code of
  (IntroductionCode "abc") -> return Unused
  (IntroductionCode "xyz") -> return Used
  _                        -> throwIO $ userError "no such introduction code"
