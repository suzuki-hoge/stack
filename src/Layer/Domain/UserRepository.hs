module Layer.Domain.UserRepository (
  module Layer.Domain.UserRepository
, module Layer.Domain.User
) where

import Control.Exception

import Layer.Domain.User


validRm = RegistrationMonth $ Month 201702
invalidRm = RegistrationMonth $ Month 201703

validOption = Nothing
invalidOption = Just $ PremiumOption $ PremiumOptionId "option-1"

contact = SmsContact $ TelephoneNumber "090-1234-5678"


findUser :: UserId -> IO User
findUser id = case id of
  (UserId "user-1") -> return $ User id   validRm   validOption   contact
  (UserId "user-2") -> return $ User id invalidRm   validOption   contact
  (UserId "user-3") -> return $ User id   validRm invalidOption   contact
  _                   -> throwIO $ userError "no such user"

