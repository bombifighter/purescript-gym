module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Console (log)
import MySQL.Pool (withPool, closePool, createPool, defaultPoolInfo, Pool)
import MySQL.Connection (execute, ConnectionInfo)
import Data.Time.Duration (Milliseconds(..))
import GymService.Persistence.GuestPersist
import GymService.Types.Guest
import MySQL.QueryValue (toQueryValue)

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

main :: Effect Unit
main = do
  launchAff_ do
    pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
    flip withPool pool \conn -> do
      let guest = Guest { bdate: "1999/11/23", email: "valami@valid.email", gender: "male", id: 2, name: "Bence", phone: "+36301234567" }
      execute
        insertGuestQuery
        [toQueryValue (getGuestId guest), toQueryValue (getGuestName guest), toQueryValue (getGuestGender guest), toQueryValue (getGuestBdate guest), toQueryValue (getGuestPhone guest), toQueryValue (getGuestEmail guest)]
        conn

    liftEffect $ closePool pool