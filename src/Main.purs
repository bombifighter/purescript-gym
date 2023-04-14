module Main where

import GymService.Persistence.GuestPersist
import GymService.Types.Guest
import Prelude

import Data.Show (show)
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Aff (Aff, launchAff, launchAff_, makeAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import HTTPure (Method(Post), Method(Get), Request, ResponseM, ServerM, notFound, ok, serve, toString)
import MySQL.Connection (execute, ConnectionInfo, Connection)
import MySQL.Pool (withPool, closePool, createPool, defaultPoolInfo, Pool)
import MySQL.QueryValue (toQueryValue)
import Simple.JSON (writeJSON)

connectionInfo :: ConnectionInfo
connectionInfo =
    { host: "localhost"
    , port: 3306
    , socketPath: ""
    , user: "root"
    , password: "alma"
    , database: "mydb"
    , charset: "UTF8_GENERAL_CI"
    , timezone: "Z"
    , connectTimeout: Milliseconds 10000.0
    , dateStrings: true
    , debug: false
    , trace: true
    , multipleStatements : false
    }

router :: Request -> ResponseM
router { method: Get, path: [ "guests/getAll" ] } = ok "valami"--do
  --guests <- getGuests conn
  --ok $ writeJSON guests
router { path: [ "goodbye" ] } = ok "valami"
router _ = notFound

port :: Int
port = 3000

main :: Effect Unit
main = do
  launchAff_ do
    pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
    router :: Request -> ResponseM
    router { method: Get, path: [ "guests/getAll" ] } = ok "valami"--do
    router { path: [ "goodbye" ] } = ok "valami"
    router _ = notFound
    liftEffect $ serve port router $ log $ "Server up running on port: " <> show port
    -- TODO router helyett inline függvény megadása
    flip withPool pool \conn -> do
      --let guest = Guest { bdate: "2004/11/22", email: "valami2@valid.email", gender: "male", id: 1, name: "Bence", phone: "+36301234567" }
      --insertGuest guest conn
      --guests <- getGuests conn
      --updateGuest id guest conn
      --deleteGuest id conn
      --log $ writeJSON guests
    liftEffect $ closePool pool