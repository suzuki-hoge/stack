module Repository (
  module Repository
, module User
) where

import User
import Fetcher


class (Monad m) => Repository m where
  find :: Id -> m User

instance Repository IO where
  find (Id id) = fetch id >>= mapper id

mapper :: (Monad m) => Int -> (String, Int) -> m User
mapper id (name, status) = return $ User (Id id) (Name name) (if status == 0 then Alive else Dead)
