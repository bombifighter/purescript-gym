module GymService.Persistence.GuestPersist where

import Prelude

import GymService.Types.Guest
import MySQL.Connection (execute, query, query_, Connection)
import MySQL.QueryValue (toQueryValue)
import Effect.Aff (Aff)


findGuestQuery :: String
findGuestQuery = "select id, name, gender, bdate, phone, email from guest where id = ?"

findGuest :: Int -> Connection -> Aff (Array Guest)
findGuest id conn = query findGuestQuery [toQueryValue id] conn

getGuestsQuery :: String
getGuestsQuery = "select id, name, gender, bdate, phone, email from guest"

getGuests :: Connection -> Aff (Array Guest)
getGuests conn = query_ getGuestsQuery conn

insertGuestQuery :: String
insertGuestQuery = "insert into guest (id, name, gender, bdate, phone, email) values (?, ?, ?, ?, ?, ?)"

insertGuest :: Guest -> Connection -> Aff Unit
insertGuest (Guest guest) conn = execute insertGuestQuery [toQueryValue guest.id, toQueryValue guest.name, toQueryValue guest.gender, toQueryValue guest.bdate, toQueryValue guest.phone, toQueryValue guest.email] conn

updateGuestQuery :: String
updateGuestQuery = "update guest set name = ?, gender = ?, bdate = ?, phone = ?, email = ? where id = ?"

updateGuest :: Int -> Guest -> Connection -> Aff Unit
updateGuest id (Guest guest) conn = execute updateGuestQuery [toQueryValue guest.name, toQueryValue guest.gender, toQueryValue guest.bdate, toQueryValue guest.phone, toQueryValue guest.email, toQueryValue id] conn

deleteGuestQuery :: String
deleteGuestQuery = "delete from guest where id = ?"

deleteGuest :: Int -> Connection -> Aff Unit
deleteGuest id conn = execute deleteGuestQuery [toQueryValue id] conn

getLastGuestIdQuery :: String
getLastGuestIdQuery = "select max(id) as lastId from guest"

getLastGuestId :: Connection -> Aff (Array {lastId :: Int})
getLastGuestId conn = query_ getLastGuestIdQuery conn