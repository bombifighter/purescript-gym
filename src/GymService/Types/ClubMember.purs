module GymService.Types.ClubMember where

import Prelude
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Yoga.JSON (readJSON_, writeJSON, class WriteForeign, class ReadForeign)
import Data.Maybe (Maybe)

newtype ClubMember = ClubMember
    { id   :: Int
    , guestId :: Int
    , endDate :: String
    }

derive instance genericClubMember :: Generic ClubMember _
derive newtype instance readForeignClubMember :: ReadForeign ClubMember
derive newtype instance writeForeignClubMember :: WriteForeign ClubMember

instance showClubMember :: Show ClubMember where
    show = genericShow

writeClubMemberJson :: ClubMember -> String
writeClubMemberJson = writeJSON

readClubMemberJson :: String -> Maybe ClubMember
readClubMemberJson = readJSON_

getClubMemberId :: ClubMember -> Int
getClubMemberId (ClubMember clubMember) = clubMember.id

getClubMemberGuestId :: ClubMember -> Int
getClubMemberGuestId (ClubMember clubMember) = clubMember.guestId

getClubMemberEndDate :: ClubMember -> String
getClubMemberEndDate (ClubMember clubMember) = clubMember.endDate

setClubMemberId :: Int -> ClubMember -> ClubMember
setClubMemberId s (ClubMember cm) = ClubMember {id:s, guestId:cm.guestId, endDate: cm.endDate}

setClubMemberGuestId :: Int -> ClubMember -> ClubMember
setClubMemberGuestId s (ClubMember cm) = ClubMember {id:cm.id, guestId:s, endDate: cm.endDate}

setClubMemberEndDate :: String -> ClubMember -> ClubMember
setClubMemberEndDate s (ClubMember cm) = ClubMember {id:cm.id, guestId:cm.guestId, endDate: s}