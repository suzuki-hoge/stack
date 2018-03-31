module Layer.Api.Parameters where

import Data.List(intercalate)

type Key = String
type Value = String
newtype Parameters = Parameters [(Key, Value)] deriving Eq

instance Show Parameters where
  show (Parameters vs) = intercalate ", " $ map (\(k, v) -> k ++ ": " ++ v) vs


(!?) :: Parameters -> Key -> Maybe Value
(!?) (Parameters tups) key = case filtered of
  []       -> Nothing
  [(_, v)] -> Just v
  where
    filtered = filter (\(k, v) -> k == key) tups
