module GymService.Persistence.LockerPersist where

import Prelude
import GymService.Types.Locker
import MySQL.Connection (execute, execute_, query, query_, Connection)
import MySQL.QueryValue (toQueryValue)
import Effect.Aff (Aff)

findLockerQuery :: String
findLockerQuery = "select id, gender, isFree from locker where id = ?"

findLocker :: Int -> Connection -> Aff (Array Locker)
findLocker id conn = query findLockerQuery [toQueryValue id] conn

getLockersQuery :: String
getLockersQuery = "select id, gender, isFree from locker"

getLockers :: Connection -> Aff (Array Locker)
getLockers conn = query_ getLockersQuery conn

insertLockerQuery :: String
insertLockerQuery = "insert into locker (id, gender, isFree) values (?, ?, ?)"

insertLocker :: Locker -> Connection -> Aff Unit
insertLocker (Locker locker) conn = execute insertLockerQuery [toQueryValue locker.id, toQueryValue locker.gender, toQueryValue locker.isFree] conn

updateLockerQuery :: String
updateLockerQuery = "update locker set gender = ?, isFree = ? where id = ?"

updateLocker :: Int -> Locker -> Connection -> Aff Unit
updateLocker id (Locker locker) conn = execute updateLockerQuery [toQueryValue locker.gender, toQueryValue locker.isFree, toQueryValue id] conn

deleteLockerQuery :: String
deleteLockerQuery = "delete from locker where id = ?"

deleteLocker :: Int -> Connection -> Aff Unit
deleteLocker id conn = execute deleteLockerQuery [toQueryValue id] conn

getMaleOccupiedLockerNumberQuery :: String
getMaleOccupiedLockerNumberQuery = "select count(*) from locker where gender = 'male'"

getMaleOccupiedLocker :: Connection -> Aff Unit
getMaleOccupiedLocker conn = execute_ getMaleOccupiedLockerNumberQuery conn

getFemaleOccupiedLockerNumberQuery :: String
getFemaleOccupiedLockerNumberQuery = "select count(*) from locker where gender = 'female'"

getFemaleOccupiedLocker :: Connection -> Aff Unit
getFemaleOccupiedLocker conn = execute_ getFemaleOccupiedLockerNumberQuery conn

--esetleg a kettő helyett egy fgv és paraméterként a gender

