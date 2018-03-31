module Layer.Service.OptionService (
  module Layer.Service.OptionService
, module Control.Monad.Trans.Either
, module Layer.Service.Application
) where

import Control.Monad.IO.Class(liftIO)
import Control.Monad.Trans.Either(EitherT, right)

import Layer.Service.Application
import Layer.Service.UserService
import Layer.Service.IntroductionService
import Layer.Domain.OptionRepository
import Layer.Domain.NoticeRepository
import Layer.Domain.User(PremiumOptionId)


contract :: Application -> EitherT BusinessError IO PremiumOptionId
contract (Application id code) = do
  contact <- checkUser id
  _ <- checkStatus code
  optionId <- liftIO $ toPremium id

  let notice = Notice (To "") (Body "")
  liftIO $ noticeTo $ mkNotice contact optionId

  right optionId

  where
    mkNotice :: Contact -> PremiumOptionId -> Notice
    mkNotice contact id = case contact of
      SmsContact (TelephoneNumber to) -> Notice (To to) $ body id
      MailContact (MailAddress to)    -> Notice (To to) $ body id
      where
        body :: PremiumOptionId -> Body
        body (PremiumOptionId id)= Body $ "thank you for contract, your premium option id is " ++ id ++ "."
