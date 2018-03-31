module Main where


import Control.Monad.Trans.Either

import Transformer.Ex1
import Transformer.Ex2
import Transformer.Ex3
import Transformer.Ex4
import Transformer.Ex5


main :: IO ()
main = do
  ex1

  sep

  print ex2

  sep

  ex3 >>= print

  sep

  runEitherT ex4 >>= print

  sep

  ex5 >>= print

sep = putStrLn "\n--\n"
