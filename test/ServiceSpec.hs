module ServiceSpec where

import Test.Hspec

import Service


instance Repository Maybe where
  find id = Just user
    where
      user = User id (Name "Mocked") Alive


spec = do
  describe "service with mocked fetcher" $ do
    it "find someone" $ do
      service (Id 1) `shouldBe` Just (User (Id 1) (Name "Mocked") Alive)
