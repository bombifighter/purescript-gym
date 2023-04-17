module GymService.Persistence.MembershipTypePersist where

import Prelude
import GymService.Types.MembershipType
import MySQL.Connection (execute, query, query_, Connection)
import MySQL.QueryValue (toQueryValue)
import Effect.Aff (Aff)


findMembershipTypeQuery :: String
findMembershipTypeQuery = "select id, name, isPass, occasions, fullPrice, studentPrice, clubPrice from membershipType where id = ?"

findMembershipType :: Int -> Connection -> Aff (Array MembershipType)
findMembershipType id conn = query findMembershipTypeQuery [toQueryValue id] conn

getMembershipTypesQuery :: String
getMembershipTypesQuery = "select id, name, isPass, occasions, fullPrice, studentPrice, clubPrice from membershipType"

getMembershipTypes :: Connection -> Aff (Array MembershipType)
getMembershipTypes conn = query_ getMembershipTypesQuery conn

insertMembershipTypeQuery :: String
insertMembershipTypeQuery = "insert into membershipType id, name, isPass, occasions, fullPrice, studentPrice, clubPrice from membershipType values (?, ?, ?, ?, ?, ?, ?)"

insertMembershipType :: MembershipType -> Connection -> Aff Unit
insertMembershipType (MembershipType membershipType) conn = execute insertMembershipTypeQuery [toQueryValue membershipType.id, toQueryValue membershipType.name, toQueryValue membershipType.isPass, toQueryValue membershipType.occasions, toQueryValue membershipType.fullPrice, toQueryValue membershipType.studentPrice, toQueryValue membershipType.clubPrice] conn

updateMembershipTypeQuery :: String
updateMembershipTypeQuery = "update membershipType set name = ?, isPass = ?, occasions = ?, fullPrice = ?, studentPrice = ?, clubPrice where id = ?"

updateMembershipType :: Int -> MembershipType -> Connection -> Aff Unit
updateMembershipType id (MembershipType membershipType) conn = execute updateMembershipTypeQuery [toQueryValue membershipType.id, toQueryValue membershipType.name, toQueryValue membershipType.isPass, toQueryValue membershipType.occasions, toQueryValue membershipType.fullPrice, toQueryValue membershipType.studentPrice, toQueryValue membershipType.clubPrice] conn

deleteMembershipTypeQuery :: String
deleteMembershipTypeQuery = "delete from membershipType where id = ?"

deleteMembershipType :: Int -> Connection -> Aff Unit
deleteMembershipType id conn = execute deleteMembershipTypeQuery [toQueryValue id] conn