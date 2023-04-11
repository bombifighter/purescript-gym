module GymService.Types.User where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Yoga.JSON (readJSON_, writeJSON, class WriteForeign, class ReadForeign)
import Data.Maybe (Maybe, fromJust)

newtype User = User
    { id   :: Int
    , name :: String
    }

derive instance genericUser :: Generic User _
derive newtype instance readForeignUser :: ReadForeign User
derive newtype instance writeForeignUser :: WriteForeign User

instance showUser :: Show User where
    show = genericShow

writeUserJson :: User -> String
writeUserJson = writeJSON

readUserJson :: String -> Maybe User
readUserJson = readJSON_