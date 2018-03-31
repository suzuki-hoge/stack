module Main where


import Prelude hiding (maybe)
import Service


io :: Int -> IO User
io id = service $ Id id

{-
  ghci> io 1
  User (Id 1) (Name "John") Alive

  ghci> io 2
  User (Id 2) (Name "Jane") Dead

  ghci> io 3
  *** Exception: Prelude.!!: index too large
-}

main :: IO ()
main = do
  putStrLn "stack workspace"
