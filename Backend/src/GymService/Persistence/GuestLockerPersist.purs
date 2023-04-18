module GymService.Persistence.GuestLockerPersist where

import Prelude
import GymService.Types.GuestLocker
import MySQL.Connection (execute, query, query_, Connection)
import MySQL.QueryValue (toQueryValue)
import Effect.Aff (Aff)


findGuestLockerQuery :: String
findGuestLockerQuery = "select id, guestId, lockerId, lockerGender, startTime, endTime from guestlocker where id = ?"

findGuestLocker :: Int -> Connection -> Aff (Array GuestLocker)
findGuestLocker id conn = query findGuestLockerQuery [toQueryValue id] conn

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