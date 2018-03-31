module Layer.Domain.User (
  module Layer.Domain.User
, module Layer.Month
, module Layer.Domain.BusinessError
) where

import Layer.Month
import Layer.Domain.BusinessError


data User = User UserId RegistrationMonth (Maybe PremiumOption) Contact deriving Show

newtype UserId = UserId String deriving (Show, Eq)
newtype RegistrationMonth = RegistrationMonth Month deriving Show
newtype ElapsedMonth = ElapsedMonth Int deriving (Show, Eq)

newtype PremiumOption = PremiumOption PremiumOptionId deriving Show
newtype PremiumOptionId = PremiumOptionId String deriving Show

data Contact = MailContact MailAddress
             | SmsContact  TelephoneNumber
             deriving Show
newtype MailAddress = MailAddress String deriving Show
newtype TelephoneNumber = TelephoneNumber String deriving Show


checkContractableUser :: User -> Month -> Either BusinessError ()
checkContractableUser (User _ registration option _) now = case (now `elapsedFrom` registration, option) of
  (ElapsedMonth n, Nothing)
    | n < 13    -> Left "not elapsed one year"
    | otherwise -> Right ()
  (ElapsedMonth n, Just _) -> Left "already premium"
  where
    elapsedFrom :: Month -> RegistrationMonth -> ElapsedMonth
    elapsedFrom now (RegistrationMonth m) = ElapsedMonth $ now `minus` m
