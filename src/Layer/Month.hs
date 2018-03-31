module Layer.Month where

newtype Month = Month Int deriving Show

minus :: Month -> Month -> Int
minus (Month x1) (Month x2) = (y1 * 12 + m1) - (y2 * 12 + m2)
  where
    y1 = x1 `div` 100
    m1 = x1 - y1 * 100
    y2 = x2 `div` 100
    m2 = x2 - y2 * 100

getNow :: IO Month
getNow = return $ Month 201803
