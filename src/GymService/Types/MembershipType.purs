module GymService.Types.MembershipType where

import Prelude
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Simple.JSON (readJSON_, writeJSON, class WriteForeign, class ReadForeign)
import Data.Maybe (Maybe)

newtype MembershipType = MembershipType
    { id   :: Int
    , name :: String
    , isPass :: Boolean
    , occasions :: Int
    , fullPrice :: Int
    , studentPrice :: Int
    , clubPrice :: Int
    }

derive instance genericMembershipType :: Generic MembershipType _
derive newtype instance readForeignMembershipType :: ReadForeign MembershipType
derive newtype instance writeForeignMembershipType :: WriteForeign MembershipType

instance showMembershipType :: Show MembershipType where
    show = genericShow

writeMembershipTypeJson :: MembershipType -> String
writeMembershipTypeJson = writeJSON

readMembershipTypeJson :: String -> Maybe MembershipType
readMembershipTypeJson = readJSON_

getMTId :: MembershipType -> Int
getMTId (MembershipType mt) = mt.id

getMTName :: MembershipType -> String
getMTName (MembershipType mt) = mt.name

getMTType :: MembershipType -> Boolean
getMTType (MembershipType mt) = mt.isPass

getMTOccasions :: MembershipType -> Int
getMTOccasions (MembershipType mt) = mt.occasions

getMTfullPrice :: MembershipType -> Int
getMTfullPrice (MembershipType mt) = mt.fullPrice

getMTStudentPrice :: MembershipType -> Int
getMTStudentPrice (MembershipType mt) = mt.studentPrice

getMTClubPrice :: MembershipType -> Int
getMTClubPrice (MembershipType mt) = mt.clubPrice

setMTId :: Int -> MembershipType -> MembershipType
setMTId s (MembershipType mt) = MembershipType {id:s, name:mt.name, isPass:mt.isPass, occasions: mt.occasions, fullPrice: mt.fullPrice, studentPrice:mt.studentPrice, clubPrice:mt.clubPrice}

setMTName :: String -> MembershipType -> MembershipType
setMTName s (MembershipType mt) = MembershipType {id:mt.id, name:s, isPass:mt.isPass, occasions: mt.occasions, fullPrice: mt.fullPrice, studentPrice:mt.studentPrice, clubPrice:mt.clubPrice}

setMTType :: Boolean -> MembershipType -> MembershipType
setMTType s (MembershipType mt) = MembershipType {id:mt.id, name:mt.name, isPass:s, occasions: mt.occasions, fullPrice: mt.fullPrice, studentPrice:mt.studentPrice, clubPrice:mt.clubPrice}

setMTOccasions :: Int -> MembershipType -> MembershipType
setMTOccasions s (MembershipType mt) = MembershipType {id:mt.id, name:mt.name, isPass:mt.isPass, occasions: s, fullPrice: mt.fullPrice, studentPrice:mt.studentPrice, clubPrice:mt.clubPrice}

setMTFullPrice :: Int -> MembershipType -> MembershipType
setMTFullPrice s (MembershipType mt) = MembershipType {id:mt.id, name:mt.name, isPass:mt.isPass, occasions: mt.occasions, fullPrice: s, studentPrice:mt.studentPrice, clubPrice:mt.clubPrice}

setMTStudentPrice :: Int -> MembershipType -> MembershipType
setMTStudentPrice s (MembershipType mt) = MembershipType {id:mt.id, name:mt.name, isPass:mt.isPass, occasions: mt.occasions, fullPrice: mt.fullPrice, studentPrice:s, clubPrice:mt.clubPrice}

setMTClubPrice :: Int -> MembershipType -> MembershipType
setMTClubPrice s (MembershipType mt) = MembershipType {id:mt.id, name:mt.name, isPass:mt.isPass, occasions: mt.occasions, fullPrice: mt.fullPrice, studentPrice:mt.studentPrice, clubPrice:s}
