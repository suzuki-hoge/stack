module Layer.Domain.Notice (
  module Layer.Domain.Notice
) where


data Notice = Notice To Body deriving Show
newtype To = To String deriving Show
newtype Body = Body String deriving Show
