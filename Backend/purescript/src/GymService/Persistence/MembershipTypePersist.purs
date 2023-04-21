module GymService.Persistence.MembershipTypePersist where

import Prelude
import GymService.Types.MembershipType
import MySQL.Connection (execute, query, query_, Connection)
import MySQL.QueryValue (toQueryValue)
import Effect.Aff (Aff)


findMembershipTypeQuery :: String
findMembershipTypeQuery = "select id, name, isPass, occasions, fullPrice, studentPrice, clubPrice from membershiptype where id = ?"

findMembershipType :: Int -> Connection -> Aff (Array MembershipType)
findMembershipType id conn = query findMembershipTypeQuery [toQueryValue id] conn

getMembershipTypesQuery :: String
getMembershipTypesQuery = "select id, name, isPass, occasions, fullPrice, studentPrice, clubPrice from membershiptype"

getMembershipTypes :: Connection -> Aff (Array MembershipType)
getMembershipTypes conn = query_ getMembershipTypesQuery conn

insertMembershipTypeQuery :: String
insertMembershipTypeQuery = "insert into membershiptype id, name, isPass, occasions, fullPrice, studentPrice, clubPrice from membershiptype values (?, ?, ?, ?, ?, ?, ?)"

insertMembershipType :: MembershipType -> Connection -> Aff Unit
insertMembershipType (MembershipType membershipType) conn = execute insertMembershipTypeQuery [toQueryValue membershipType.id, toQueryValue membershipType.name, toQueryValue membershipType.isPass, toQueryValue membershipType.occasions, toQueryValue membershipType.fullPrice, toQueryValue membershipType.studentPrice, toQueryValue membershipType.clubPrice] conn

updateMembershipTypeQuery :: String
updateMembershipTypeQuery = "update membershiptype set name = ?, isPass = ?, occasions = ?, fullPrice = ?, studentPrice = ?, clubPrice where id = ?"

updateMembershipType :: Int -> MembershipType -> Connection -> Aff Unit
updateMembershipType id (MembershipType membershipType) conn = execute updateMembershipTypeQuery [toQueryValue membershipType.id, toQueryValue membershipType.name, toQueryValue membershipType.isPass, toQueryValue membershipType.occasions, toQueryValue membershipType.fullPrice, toQueryValue membershipType.studentPrice, toQueryValue membershipType.clubPrice] conn

deleteMembershipTypeQuery :: String
deleteMembershipTypeQuery = "delete from membershiptype where id = ?"

deleteMembershipType :: Int -> Connection -> Aff Unit
deleteMembershipType id conn = execute deleteMembershipTypeQuery [toQueryValue id] conn