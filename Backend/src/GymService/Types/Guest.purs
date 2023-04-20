module GymService.Types.Guest where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Simple.JSON (readJSON_, writeJSON, class WriteForeign, class ReadForeign)
import Data.Maybe (Maybe)

newtype Guest = Guest
    { id   :: Int
    , name :: String
    , gender :: String
    , bdate :: String
    , phone :: String
    , email :: String
    }

derive instance genericGuest :: Generic Guest _
derive newtype instance readForeignGuest :: ReadForeign Guest
derive newtype instance writeForeignGuest :: WriteForeign Guest

instance showGuest :: Show Guest where
    show = genericShow

writeGuestJson :: Guest -> String
writeGuestJson = writeJSON

readGuestJson :: String -> Maybe Guest
readGuestJson = readJSON_

readCheckinJson :: String -> Maybe { guestId :: Int, gender :: String}
readCheckinJson = readJSON_

readCheckoutJson :: String -> Maybe { guestId :: Int, gender :: String, lockerId :: Int}
readCheckoutJson = readJSON_

getGuestId :: Guest -> Int
getGuestId (Guest guest) = guest.id

getGuestName :: Guest -> String
getGuestName (Guest guest) = guest.name

getGuestGender :: Guest -> String
getGuestGender (Guest guest) = guest.gender

getGuestBdate :: Guest -> String
getGuestBdate (Guest guest) = guest.bdate

getGuestPhone :: Guest -> String
getGuestPhone (Guest guest) = guest.phone

getGuestEmail :: Guest -> String
getGuestEmail (Guest guest) = guest.email

setGuestName :: String -> Guest -> Guest
setGuestName newName (Guest guest) = Guest {id:guest.id, name:newName, gender:guest.gender, bdate:guest.bdate, phone:guest.phone, email:guest.email}

setGuestId :: Int -> Guest -> Guest
setGuestId s (Guest guest) = Guest {id:s, name:guest.name, gender:guest.gender, bdate:guest.bdate, phone:guest.phone, email:guest.email}

setGuestGender :: String -> Guest -> Guest
setGuestGender s (Guest guest) = Guest {id:guest.id, name:guest.name, gender:s, bdate:guest.bdate, phone:guest.phone, email:guest.email}

setGuestBdate :: String -> Guest -> Guest
setGuestBdate s (Guest guest) = Guest {id:guest.id, name:guest.name, gender:guest.gender, bdate:s, phone:guest.phone, email:guest.email}

setGuestPhone :: String -> Guest -> Guest
setGuestPhone s (Guest guest) = Guest {id:guest.id, name:guest.name, gender:guest.gender, bdate:guest.bdate, phone:s, email:guest.email}

setGuestEmail :: String -> Guest -> Guest
setGuestEmail s (Guest guest) = Guest {id:guest.id, name:guest.name, gender:guest.gender, bdate:guest.bdate, phone:guest.phone, email:s}