module Transformer.Ex2 where

import Transformer.Types


asMail :: To -> Subject -> Body -> Mail
asMail to sub body = "send to " ++ to ++ " [" ++ sub ++ "] " ++ body

findHospital :: Address -> Either String Hospital
findHospital address = Left "no such hospital"

getHoliday :: Hospital -> Either String Holiday
getHoliday hospital = Left "holiday is not registered"

getToday :: Today
getToday = "mon"

asConclusion :: Holiday -> Today -> Hospital -> Conclusion
asConclusion holiday today hospital = case holiday == today of
  True -> "stay home"
  False -> "go " ++ hospital


ex2 :: Either String Conclusion
ex2 = do
  let mail = asMail "office" "sorry" "I caught cold."
  hospital <- findHospital "tokyo"
  holiday <- getHoliday hospital
  let today = getToday
  let conclusion = asConclusion holiday today hospital

  return conclusion
