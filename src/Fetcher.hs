module Fetcher where

import Data.List.Split


class (Monad m) => Fetcher m where
  fetch :: Int -> m (String, Int)

instance Fetcher IO where
  fetch id = do
    [name, status] <- (splitOn ",") . (!! id) . lines <$> readFile "table/user.csv"
    return (name, read status)
