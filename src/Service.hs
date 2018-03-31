module Service (
  module Service
, module Repository
) where

import Repository


service :: (Repository m) => Id -> m User
service id = do
  user <- find id
  return user
