module Layer.Domain.UserSpec where

import Test.Hspec

import Layer.Month
import Layer.Domain.User


now :: Month
now = Month 201803

rm :: Int -> RegistrationMonth
rm = RegistrationMonth . Month

mkUser :: Int -> Maybe PremiumOption -> User
mkUser registration option = User (UserId "user-1") (rm registration) option (SmsContact $ TelephoneNumber "090-1234-5678")

option :: PremiumOption
option = PremiumOption $ PremiumOptionId "option-1"


spec :: Spec
spec = do
  describe "checkContractableUser" $ do
    it "not contractable if already have" $ do
      let user = mkUser 201702 (Just option)
      checkContractableUser user now `shouldBe` Left "already premium"

    it "not contractable when no enough elapsed month" $ do
      let user = mkUser 201803 Nothing
      checkContractableUser user now `shouldBe` Left "not elapsed one year"

    it "contractable with no option and enough elapsed month" $ do
      let user = mkUser 201702 Nothing
      checkContractableUser user now `shouldBe` Right ()
