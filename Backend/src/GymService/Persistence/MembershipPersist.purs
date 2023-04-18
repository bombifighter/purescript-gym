module GymService.Persistence.MembershipPersist where

import Prelude
import GymService.Types.Membership
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
updateMembership id (Membership membership) conn = execute updateMembershipQuery [toQueryValue membership.id, toQueryValue membership.guestId, toQueryValue membership.membershipTypeId, toQueryValue membership.endDate, toQueryValue membership.occasionsLeft] conn

deleteMembershipQuery :: String
deleteMembershipQuery = "delete from membership where id = ?"

deleteMembership :: Int -> Connection -> Aff Unit
deleteMembership id conn = execute deleteMembershipQuery [toQueryValue id] conn