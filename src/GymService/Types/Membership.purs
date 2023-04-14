module GymService.Types.Membership where

import Prelude
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Simple.JSON (readJSON_, writeJSON, class WriteForeign, class ReadForeign)
import Data.Maybe (Maybe)

newtype Membership = Membership
    { id   :: Int
    , guestId :: Int
    , membershipTypeId :: Int
    , endDate :: String
    , occasionsLeft :: Int
    }

derive instance genericMembership :: Generic Membership _
derive newtype instance readForeignMembership :: ReadForeign Membership
derive newtype instance writeForeignMembership :: WriteForeign Membership

instance showMembership :: Show Membership where
    show = genericShow

writeMembershipJson :: Membership -> String
writeMembershipJson = writeJSON

readMembershipJson :: String -> Maybe Membership
readMembershipJson = readJSON_

getMembershipId :: Membership -> Int
getMembershipId (Membership membership) = membership.id

getMembershipGuestId :: Membership -> Int
getMembershipGuestId (Membership membership) = membership.guestId

getMembershipMTId :: Membership -> Int
getMembershipMTId (Membership membership) = membership.membershipTypeId

getMembershipEndDate :: Membership -> String
getMembershipEndDate (Membership membership) = membership.endDate

getMembershipOccasionsLeft :: Membership -> Int
getMembershipOccasionsLeft (Membership membership) = membership.occasionsLeft

setMembershipId :: Int -> Membership -> Membership
setMembershipId s (Membership m) = Membership {id:s, guestId:m.guestId, membershipTypeId: m.membershipTypeId, endDate:m.endDate, occasionsLeft:m.occasionsLeft}

setMembershipGuestId :: Int -> Membership -> Membership
setMembershipGuestId s (Membership m) = Membership {id:m.id, guestId:s, membershipTypeId: m.membershipTypeId, endDate:m.endDate, occasionsLeft:m.occasionsLeft}

setMembershipMTId :: Int -> Membership -> Membership
setMembershipMTId s (Membership m) = Membership {id:m.id, guestId:m.guestId, membershipTypeId: s, endDate:m.endDate, occasionsLeft:m.occasionsLeft}

setMembershipEndDate :: String -> Membership -> Membership
setMembershipEndDate s (Membership m) = Membership {id:m.id, guestId:m.guestId, membershipTypeId: m.membershipTypeId, endDate:s, occasionsLeft:m.occasionsLeft}

setMembershipOccasionsLeft :: Int -> Membership -> Membership
setMembershipOccasionsLeft s (Membership m) = Membership {id:m.id, guestId:m.guestId, membershipTypeId: m.membershipTypeId, endDate:m.endDate, occasionsLeft:s}