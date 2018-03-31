module User where

newtype Id = Id Int deriving (Show, Eq)
newtype Name = Name String deriving (Show, Eq)
data Status = Alive | Dead deriving (Show, Eq)

data User = User Id Name Status deriving (Show, Eq)
