module RepositorySpec where

import Test.Hspec

import Repository
import Fetcher


instance Fetcher Maybe where
  fetch 1 = Just ("Mocked", 0)
  fetch 2 = Just ("Mocked", 1)


instance Repository Maybe where
  find (Id id) = fetch id >>= mapper id -- ???


spec = do
  describe "repository with mocked fetcher" $ do
    it "convert 0 -> Alive" $ do
      find (Id 1) `shouldBe` Just (User (Id 1) (Name "Mocked") Alive)

    it "convert 1 -> Dead" $ do
      find (Id 2) `shouldBe` Just (User (Id 2) (Name "Mocked") Dead)
