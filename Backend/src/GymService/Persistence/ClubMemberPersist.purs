module GymService.Persistence.ClubMember where

import Prelude
import Prelude
import GymService.Types.ClubMember
import MySQL.Connection (execute, query, query_, Connection)
import MySQL.QueryValue (toQueryValue)
import Effect.Aff (Aff)

findClubMemberQuery :: String
findClubMemberQuery = "select id, guestId, endDate from clubMember where id = ?"

findClubMember :: Int -> Connection -> Aff (Array ClubMember)
findClubMember id conn = query findClubMemberQuery [toQueryValue id] conn

getClubMembersQuery :: String
getClubMembersQuery = "select id, guestId, endDate from clubMember"

getClubMembers :: Connection -> Aff (Array ClubMember)
getClubMembers conn = query_ getClubMembersQuery conn

insertClubMemberQuery :: String
insertClubMemberQuery = "insert into clubMember (id, guestId, endDate) values (?, ?, ?)"

insertClubMember :: ClubMember -> Connection -> Aff Unit
insertClubMember (ClubMember clubMember) conn = execute insertClubMemberQuery [toQueryValue clubMember.id, toQueryValue clubMember.guestId, toQueryValue clubMember.endDate] conn

updateClubMemberQuery :: String
updateClubMemberQuery = "update clubMember set guestId = ?, endDate = ? where id = ?"

updateClubMember :: Int -> ClubMember -> Connection -> Aff Unit
updateClubMember (ClubMember clubMember) conn = execute updateClubMemberQuery [toQueryValue clubMember.guestId, toQueryValue clubMember.endDate, toQueryValue clubMember.id] conn

deleteClubMemberQuery :: String
deleteClubMemberQuery = "delete from clubMember where id = ?"

deleteClubMember :: Int -> Connection -> Aff Unit
deleteClubMember id conn = execute deleteClubMemberQuery [toQueryValue id] conn