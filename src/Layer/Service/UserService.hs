module Layer.Service.UserService (
  module Layer.Service.UserService
, module Control.Monad.IO.Class
, module Control.Monad.Trans.Either
) where

import Control.Monad.IO.Class(liftIO)
import Control.Monad.Trans.Either(EitherT, hoistEither)

import Layer.Domain.UserRepository


checkUser :: UserId -> EitherT BusinessError IO Contact
checkUser id = do
  user <- liftIO $ findUser id
  now <- liftIO getNow

  hoistEither $ asContact user `fmap` checkContractableUser user now

  where
    asContact :: User -> () -> Contact
    asContact (User _ _ _ contact) _ = contact
