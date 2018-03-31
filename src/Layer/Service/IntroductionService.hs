module Layer.Service.IntroductionService (
  module Layer.Service.IntroductionService
, module Control.Monad.IO.Class
, module Control.Monad.Trans.Either
) where

import Control.Monad.IO.Class(liftIO)
import Control.Monad.Trans.Either(EitherT, hoistEither)

import Layer.Domain.IntroductionRepository


checkStatus :: IntroductionCode -> EitherT BusinessError IO ()
checkStatus code = do
  status <- liftIO $ findStatus code

  hoistEither $ checkContractableCode status
