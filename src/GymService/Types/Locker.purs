module GymService.Types.Locker where

import Prelude
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Yoga.JSON (readJSON_, writeJSON, class WriteForeign, class ReadForeign)
import Data.Maybe (Maybe)

newtype Locker = Locker
    { id   :: Int
    , gender :: String
    , isFree :: Boolean
    }

derive instance genericLocker :: Generic Locker _
derive newtype instance readForeignLocker :: ReadForeign Locker
derive newtype instance writeForeignLocker :: WriteForeign Locker

instance showLocker :: Show Locker where
    show = genericShow

writeLockerJson :: Locker -> String
writeLockerJson = writeJSON

readLockerJson :: String -> Maybe Locker
readLockerJson = readJSON_

getLockerId :: Locker -> Int
getLockerId (Locker locker) = locker.id

getLockerGender :: Locker -> String
getLockerGender (Locker locker) = locker.gender

getLockerStatus :: Locker -> Boolean
getLockerStatus (Locker locker) = locker.isFree

setLockerId :: Int -> Locker -> Locker
setLockerId s (Locker locker) = Locker {id:s, gender:locker.gender, isFree:locker.isFree}

setLockerGender :: String -> Locker -> Locker
setLockerGender s (Locker locker) = Locker {id:locker.id, gender:s, isFree:locker.isFree}

setLockerStatus :: Boolean -> Locker -> Locker
setLockerStatus s (Locker locker) = Locker {id:locker.id, gender:locker.gender, isFree:s}