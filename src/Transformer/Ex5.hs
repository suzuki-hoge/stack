module Transformer.Ex5 where

import Control.Exception

ioExcept :: IO String
ioExcept = readFile "invalid"

eitherExcept :: IO (Either String String)
eitherExcept = do
  out <- readFile "invalid"
  return $ Right out

ex5 :: IO String
ex5 = do
  ioOut <- ioExcept `catch` \(SomeException e) -> return "thrown!!!"
  print ioOut

  eitherOut <- eitherExcept `catch` \(SomeException e) -> return $ Left "foo error?"
  print eitherOut

  return "done"
