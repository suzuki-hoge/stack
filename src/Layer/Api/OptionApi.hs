module Layer.Api.OptionApi (
  module Layer.Api.OptionApi
, module Layer.Api.Parameters
) where

import Data.List(intercalate)
import Control.Monad.Trans.Either(runEitherT)
import Control.Exception(catch, SomeException(..), toException)
import Layer.Api.Form
import Layer.Api.Parameters
import Layer.Service.OptionService
import Layer.Domain.User


invoke :: Parameters -> IO Parameters
invoke input = case applicationForm input of
  Success app -> runWithHandle app `catch` asSystemError
  Failure es  -> return $ asValidationError es


runWithHandle :: Application -> IO Parameters
runWithHandle app = do
  res <- runEitherT $ contract app
  return $ case res of
    Right id   -> asSuccess id
    Left error -> asBusinessError error


asSuccess :: PremiumOptionId -> Parameters
asSuccess (PremiumOptionId id) = Parameters [("result", id)]


asBusinessError :: BusinessError -> Parameters
asBusinessError error = Parameters [("result", "business-error"), ("message", error)]


asSystemError :: SomeException -> IO Parameters
asSystemError e = return $ Parameters [("result", "system-error"), ("message", show e)]

asValidationError :: ValidationErrors -> Parameters
asValidationError errors = Parameters [("result", "validation-error"), ("message", "[" ++ intercalate ", " errors ++ "]")]

