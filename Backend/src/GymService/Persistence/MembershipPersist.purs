module GymService.Persistence.MembershipPersist where

import Prelude (Unit)
import GymService.Types.Membership (Membership(..))
import MySQL.Connection (execute, query, query_, Connection)
import MySQL.QueryValue (toQueryValue)
import Effect.Aff (Aff)


findMembershipQuery :: String
findMembershipQuery = "select id, guestId, membershipTypeId, endDate, occasionsLeft from membership where guestId = ?"

findMembership :: Int -> Connection -> Aff (Array Membership)
findMembership id conn = query findMembershipQuery [toQueryValue id] conn

getMembershipsQuery :: String
getMembershipsQuery = "select id, guestId, membershipTypeId, endDate, occasionsLeft from membership"

getMemberships :: Connection -> Aff (Array Membership)
getMemberships conn = query_ getMembershipsQuery conn

insertMembershipQuery :: String
insertMembershipQuery = "insert into membership (id, guestId, membershipTypeId, endDate, occasionsLeft) values (?, ?, ?, ?, ?)"

insertMembership :: Membership -> Connection -> Aff Unit
insertMembership (Membership membership) conn = execute insertMembershipQuery [toQueryValue membership.id, toQueryValue membership.guestId, toQueryValue membership.membershipTypeId, toQueryValue membership.endDate, toQueryValue membership.occasionsLeft] conn

updateMembershipQuery :: String
updateMembershipQuery = "update membership set guestId = ?, membershipTypeId = ?, endDate = ?, occasionsLeft = ? where id = ?"

updateMembership :: Int -> Membership -> Connection -> Aff Unit
updateMembership id (Membership membership) conn = execute updateMembershipQuery [toQueryValue membership.id, toQueryValue membership.guestId, toQueryValue membership.membershipTypeId, toQueryValue membership.endDate, toQueryValue membership.occasionsLeft, toQueryValue id] conn

deleteMembershipQuery :: String
deleteMembershipQuery = "delete from membership where guestId = ?"

deleteMembership :: Int -> Connection -> Aff Unit
deleteMembership guestId conn = execute deleteMembershipQuery [toQueryValue guestId] conn

getLastMemberIdQuery :: String
getLastMemberIdQuery = "select ifnull(max(id),0) as lastId from membership"

getLastMemberId :: Connection -> Aff (Array {lastId :: Int})
getLastMemberId conn = query_ getLastMemberIdQuery conn

getOccasionsLeftQuery :: String
getOccasionsLeftQuery = "select id, occasionsLeft from membership where guestId = ? and endDate >= ?"

getOccasionsLeft :: Int -> String -> Connection -> Aff (Array { id :: Int, occasionsLeft :: Int})
getOccasionsLeft guestId endDate conn = query getOccasionsLeftQuery [toQueryValue guestId, toQueryValue endDate] conn

setOccasionsQuery :: String
setOccasionsQuery = "update membership set occasionsLeft = ? where id = ?"

setOccasions :: Int -> Int -> Connection -> Aff Unit
setOccasions newOccasions id conn = execute setOccasionsQuery [toQueryValue newOccasions, toQueryValue id] conn