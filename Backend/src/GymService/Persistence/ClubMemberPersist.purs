module GymService.Persistence.ClubMemberPersist where

import Prelude (Unit)
import GymService.Types.ClubMember (ClubMember(..))
import MySQL.Connection (execute, query, query_, Connection)
import MySQL.QueryValue (toQueryValue)
import Effect.Aff (Aff)

findClubMemberQuery :: String
findClubMemberQuery = "select id, guestId, endDate from clubmember where guestId = ?"

findClubMember :: Int -> Connection -> Aff (Array ClubMember)
findClubMember id conn = query findClubMemberQuery [toQueryValue id] conn

getClubMembersQuery :: String
getClubMembersQuery = "select id, guestId, endDate from clubmember"

getClubMembers :: Connection -> Aff (Array ClubMember)
getClubMembers conn = query_ getClubMembersQuery conn

insertClubMemberQuery :: String
insertClubMemberQuery = "insert into clubmember (id, guestId, endDate) values (?, ?, ?)"

insertClubMember :: ClubMember -> Connection -> Aff Unit
insertClubMember (ClubMember clubMember) conn = execute insertClubMemberQuery [toQueryValue clubMember.id, toQueryValue clubMember.guestId, toQueryValue clubMember.endDate] conn

updateClubMemberQuery :: String
updateClubMemberQuery = "update clubmember set guestId = ?, endDate = ? where id = ?"

updateClubMember :: Int -> ClubMember -> Connection -> Aff Unit
updateClubMember id (ClubMember clubMember) conn = execute updateClubMemberQuery [toQueryValue clubMember.guestId, toQueryValue clubMember.endDate, toQueryValue id] conn

deleteClubMemberQuery :: String
deleteClubMemberQuery = "delete from clubmember where guestId = ?"

deleteClubMember :: Int -> Connection -> Aff Unit
deleteClubMember guestId conn = execute deleteClubMemberQuery [toQueryValue guestId] conn

getLastClubMemberIdQuery :: String
getLastClubMemberIdQuery = "select max(id) as lastId from clubmember"

getLastClubMemberId :: Connection -> Aff (Array {lastId :: Int})
getLastClubMemberId conn = query_ getLastClubMemberIdQuery conn