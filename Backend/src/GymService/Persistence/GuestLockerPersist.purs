module GymService.Persistence.GuestLockerPersist where

import Prelude
import GymService.Types.GuestLocker
import MySQL.Connection (execute, query, query_, Connection)
import MySQL.QueryValue (toQueryValue)
import Effect.Aff (Aff)


findGuestLockerQuery :: String
findGuestLockerQuery = "select id, guestId, lockerId, lockerGender, startTime, endTime from guestlocker where lockerGender = ? and lockerId = ?"

findGuestLocker :: String -> Int -> Connection -> Aff (Array GuestLocker)
findGuestLocker gender id conn = query findGuestLockerQuery [toQueryValue gender, toQueryValue id] conn

getGuestLockersQuery :: String
getGuestLockersQuery = "select id, guestId, lockerId, lockerGender, startTime, endTime from guestlocker "

getGuestLockers :: Connection -> Aff (Array GuestLocker)
getGuestLockers conn = query_ getGuestLockersQuery conn

insertGuestLockerQuery :: String
insertGuestLockerQuery = "insert into guestlocker (id, guestId, lockerId, lockerGender, startTime, endTime) values (?, ?, ?, ?, ?, ?)"

insertGuestLocker :: GuestLocker -> Connection -> Aff Unit
insertGuestLocker (GuestLocker guestLocker) conn = execute insertGuestLockerQuery [toQueryValue guestLocker.id, toQueryValue guestLocker.guestId, toQueryValue guestLocker.lockerId, toQueryValue guestLocker.lockerGender, toQueryValue guestLocker.startTime, toQueryValue guestLocker.endTime] conn

updateGuestLockerQuery :: String
updateGuestLockerQuery = "update guestlocker set guestId = ?, lockerId = ?, lockerGender = ?, startTime = ?, endTime = ? where id = ?"

updateGuestLocker :: Int -> GuestLocker -> Connection -> Aff Unit
updateGuestLocker id (GuestLocker guestLocker) conn = execute updateGuestLockerQuery [toQueryValue guestLocker.id, toQueryValue guestLocker.guestId, toQueryValue guestLocker.lockerId, toQueryValue guestLocker.lockerGender, toQueryValue guestLocker.startTime, toQueryValue guestLocker.endTime] conn

deleteGuestLockerQuery :: String
deleteGuestLockerQuery = "delete from guestlocker where id = ?"

deleteGuestLocker :: Int -> Connection -> Aff Unit
deleteGuestLocker id conn = execute deleteGuestLockerQuery [toQueryValue id] conn

getUsedGuestLockersQuery :: String
getUsedGuestLockersQuery = "select id, guestId, lockerId, lockerGender, startTime, endTime from guestlocker where endTime = 0"

getUsedGuestLockers :: Connection -> Aff (Array GuestLocker)
getUsedGuestLockers conn = query_ getUsedGuestLockersQuery conn

getLastGuestLockerIdQuery :: String
getLastGuestLockerIdQuery = "select ifnull(max(id),0) as lastId from guestlocker"

getLastGuestLockerId :: Connection -> Aff (Array Int)
getLastGuestLockerId conn = query_ getLastGuestLockerIdQuery conn