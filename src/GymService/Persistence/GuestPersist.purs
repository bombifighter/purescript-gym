module GymService.Persistence.GuestPersist where

import Prelude


insertGuestQuery :: String
insertGuestQuery = "insert into guest (id, name, gender, bdate, phone, email) values (?, ?, ?, ?, ?, ?)"

findGuestQuery :: String
findGuestQuery = "select id, name, gender, bdate, phone, email from guest where id = ?"

-- TODO more query