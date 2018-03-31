module Main where

import Layer.Api.OptionApi


main :: IO ()
main = do
  main' $ Parameters [("user-id-form", "user-1"), ("introduction-code-form", "abc")]
  main' $ Parameters [("user-id", "user-1")]
  main' $ Parameters [("user-id-form", "user-2"), ("introduction-code-form", "abc")]
  main' $ Parameters [("user-id-form", "user-4"), ("introduction-code-form", "abc")]


main' :: Parameters -> IO ()
main' input = do
  putStr "\n"
  output <- invoke input
  print output
