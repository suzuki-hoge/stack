module Layer.Domain.Introduction (
  module Layer.Domain.Introduction
, module Layer.Domain.BusinessError
) where

import Layer.Domain.BusinessError

newtype IntroductionCode = IntroductionCode String deriving (Show, Eq)
data IntroductionCodeStatus = Unused | Used deriving Show

checkContractableCode :: IntroductionCodeStatus -> Either BusinessError ()
checkContractableCode Unused = Right ()
checkContractableCode Used = Left "used introduction code"
