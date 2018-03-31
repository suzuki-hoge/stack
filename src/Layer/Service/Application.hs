module Layer.Service.Application (
  module Layer.Service.Application
, module Layer.Domain.User
, module Layer.Domain.Introduction
) where


import Layer.Domain.User
import Layer.Domain.Introduction


data Application = Application UserId IntroductionCode deriving (Show, Eq)
