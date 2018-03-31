module Transformer.Ex1 where

import Transformer.Types


sendMail :: To -> Subject -> Body -> IO ()
sendMail to sub body = putStrLn $ "send to " ++ to ++ " [" ++ sub ++ "] " ++ body

findHospital :: Address -> IO Hospital
findHospital address = return $ address ++ " hospital"

getHoliday :: Hospital -> IO Holiday
getHoliday hospital = return "wed"

getToday :: IO Today
getToday = return "mon"

asConclusion :: Holiday -> Today -> Hospital -> IO Conclusion
asConclusion holiday today hospital = case holiday == today of
  True -> return "stay home"
  False -> return $ "go " ++ hospital


ex1 :: IO ()
ex1 = do
  sendMail "office" "sorry" "I caught cold."
  hospital <- findHospital "tokyo"
  holiday <- getHoliday hospital
  today <- getToday
  conclusion <- asConclusion holiday today hospital

  print conclusion
