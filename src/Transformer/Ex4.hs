module Transformer.Ex4 where

import Control.Monad.IO.Class(liftIO)
import Control.Monad.Trans.Either

import Transformer.Types


asMail :: To -> Subject -> Body -> Mail
asMail to sub body = "send to " ++ to ++ " [" ++ sub ++ "] " ++ body

sendMail :: Mail -> IO ()
sendMail = putStrLn

findHospital :: Address -> EitherT Error IO Hospital
findHospital address = left "no such hospital"

getHoliday :: Hospital -> EitherT Error IO Holiday
getHoliday hospital = left "holiday is not registered"

getToday :: IO Today
getToday = return "mon"

asConclusion :: Holiday -> Today -> Hospital -> Conclusion
asConclusion holiday today hospital
  | holiday == today = "stay home"
  | otherwise        = "go " ++ hospital


ex4 :: EitherT Error IO Conclusion
ex4 = do
  let mail = asMail "office" "sorry" "I caught cold."
  liftIO $ sendMail mail

  hospital <- findHospital "tokyo"
  holiday <- getHoliday hospital

  today <- liftIO getToday

  return $ asConclusion holiday today hospital

-- https://aiya000.github.io/posts/2016-07-21-currency_haskell_exception.html
