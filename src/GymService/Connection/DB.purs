module GymService.Connection.DB where

import Prelude

import MySQL.Connection (ConnectionInfo)
import Data.Time.Duration (Milliseconds(..))
import MySQL.Pool (createPool, defaultPoolInfo, Pool)
import Effect (Effect)

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

createPool' :: Effect Pool
createPool' = createPool connectionInfo defaultPoolInfo