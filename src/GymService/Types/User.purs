module GymService.Types.User where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Data.Argonaut.Decode.Class (class DecodeJson)
import Data.Argonaut.Decode.Generic (genericDecodeJson)
import Data.Argonaut.Encode.Class (class EncodeJson)
import Data.Argonaut.Encode.Generic (genericEncodeJson)

newtype User = User
    { id   :: Int
    , name :: String
    }

derive instance genericUser :: Generic User _

instance showUser :: Show User where
    show = genericShow

instance decodeJson :: DecodeJson User where
    decodeJson = genericDecodeJson

instance encodeJson :: EncodeJson User where
    encodeJson = genericEncodeJson