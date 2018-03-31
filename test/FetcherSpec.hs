module FetcherSpec where

import Test.Hspec

import Fetcher


instance Fetcher Maybe where
  fetch 1 = Just ("Mocked", 0)
  fetch 2 = Just ("Mocked", 1)


spec = do
  describe "non-mocked fetcher" $ do
    it "parse real csv by 1" $ do
      fetch 1 `shouldReturn` ("John", 0)

    it "parse real csv by 2" $ do
      fetch 2 `shouldReturn` ("Jane", 1)

  describe "mocked fetcher" $ do
    it "return mocked name" $ do
      fetch 1 `shouldBe` Just ("Mocked", 0)

    it "return mocked name" $ do
      fetch 2 `shouldBe` Just ("Mocked", 1)
