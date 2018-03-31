module Layer.Domain.NoticeRepository (
  module Layer.Domain.NoticeRepository
, module Layer.Domain.User
, module Layer.Domain.Notice
) where

import Layer.Domain.User
import Layer.Domain.Notice


noticeTo :: Notice -> IO ()
noticeTo (Notice (To to) (Body body)) = putStrLn $ "Notice [to: " ++ to ++ ", body: " ++ body ++ "]"
