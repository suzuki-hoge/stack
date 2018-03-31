module Layer.Domain.OptionRepository (
  module Layer.Domain.OptionRepository
, module Layer.Domain.User
) where

import Control.Exception

import Layer.Domain.User


toPremium :: UserId -> IO PremiumOptionId
toPremium id = return $ PremiumOptionId "option-1"
