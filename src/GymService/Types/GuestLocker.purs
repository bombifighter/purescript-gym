module GymService.Types.GuestLocker where

import Prelude
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Yoga.JSON (readJSON_, writeJSON, class WriteForeign, class ReadForeign)
import Data.Maybe (Maybe)

newtype GuestLocker = GuestLocker
    { id   :: Int
    , guestId :: Int
    , lockerId ::Int
    , lockerGender :: String
    , startTime :: String
    , endTime :: String
    }

derive instance genericGuestLocker :: Generic GuestLocker _
derive newtype instance readForeignGuestLocker :: ReadForeign GuestLocker
derive newtype instance writeForeignGuestLocker :: WriteForeign GuestLocker

instance showGuestLocker :: Show GuestLocker where
    show = genericShow

writeGuestLockerJson :: GuestLocker -> String
writeGuestLockerJson = writeJSON

readGuestLockerJson :: String -> Maybe GuestLocker
readGuestLockerJson = readJSON_

getGuestLockerId :: GuestLocker -> Int
getGuestLockerId (GuestLocker gl) = gl.id

getGuestLockerGuestId :: GuestLocker -> Int
getGuestLockerGuestId (GuestLocker gl) = gl.guestId

getGuestLockerLockerId :: GuestLocker -> Int
getGuestLockerLockerId (GuestLocker gl) = gl.lockerId

getGuestLockerLockerGender :: GuestLocker -> String
getGuestLockerLockerGender (GuestLocker gl) = gl.lockerGender

getGuestLockerStartTime :: GuestLocker -> String
getGuestLockerStartTime (GuestLocker gl) = gl.startTime

getGuestLockerEndTime :: GuestLocker -> String
getGuestLockerEndTime (GuestLocker gl) = gl.endTime

setGuestLockerId :: Int -> GuestLocker -> GuestLocker
setGuestLockerId s (GuestLocker gl) = GuestLocker {id: s, guestId:gl.guestId, lockerId:gl.lockerId, lockerGender:gl.lockerGender, startTime:gl.startTime, endTime:gl.endTime}

setGuestLockerGuestId :: Int -> GuestLocker -> GuestLocker
setGuestLockerGuestId s (GuestLocker gl) = GuestLocker {id: gl.id, guestId:s, lockerId:gl.lockerId, lockerGender:gl.lockerGender, startTime:gl.startTime, endTime:gl.endTime}

setGuestLockerLockerId :: Int -> GuestLocker -> GuestLocker
setGuestLockerLockerId s (GuestLocker gl) = GuestLocker {id: gl.id, guestId:gl.guestId, lockerId:s, lockerGender:gl.lockerGender, startTime:gl.startTime, endTime:gl.endTime}

setGuestLockerLockerGender :: String -> GuestLocker -> GuestLocker
setGuestLockerLockerGender s (GuestLocker gl) = GuestLocker {id: gl.id, guestId:gl.guestId, lockerId:gl.lockerId, lockerGender:s, startTime:gl.startTime, endTime:gl.endTime}

setGuestLockerStartTime :: String -> GuestLocker -> GuestLocker
setGuestLockerStartTime s (GuestLocker gl) = GuestLocker {id: gl.id, guestId:gl.guestId, lockerId:gl.lockerId, lockerGender:gl.lockerGender, startTime:s, endTime:gl.endTime}

setGuestLockerEndTime :: String -> GuestLocker -> GuestLocker
setGuestLockerEndTime s (GuestLocker gl) = GuestLocker {id: gl.id, guestId:gl.guestId, lockerId:gl.lockerId, lockerGender:gl.lockerGender, startTime:gl.startTime, endTime:s}