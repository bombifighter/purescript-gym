module Main where

import GymService.Persistence.GuestPersist
import GymService.Types.Guest
import Prelude

import Data.Array (length)
import Data.Int (fromString)
import Data.Maybe (Maybe(Nothing, Just))
import Data.Posix.Signal (Signal(SIGINT, SIGTERM))
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import HTTPure (Method(Get, Post, Put, Delete), Request, ResponseM, badRequest, notFound, ok, serve, (!!), (!@), toString)
import MySQL.Connection (ConnectionInfo)
import MySQL.Pool (withPool, closePool, createPool, defaultPoolInfo)
import Node.Process (onSignal)
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
router { method: Get, path: [ "guest", "getAll" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  guests <- flip withPool pool \conn -> getGuests conn
  liftEffect $ closePool pool
  ok $ writeJSON guests

router { method: Get, path }
  | path !@ 0 == "guest" && path !@ 1 == "getById" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest "Last parameter is not a valid id (not an integer)"
            Just id -> do
              guest <- flip withPool pool \conn -> findGuest id conn
              liftEffect $ closePool pool
              ok $ writeJSON guest

router { body, method: Post, path }
  | path !@ 0 == "guest" && path !@ 1 == "insertGuest" = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      requestBody <- toString body
      let parsedBody = readGuestJson requestBody
      case parsedBody of
        Nothing -> badRequest "The request body is not a valid guest"
        Just guest -> do
          flip withPool pool \conn -> insertGuest guest conn
          liftEffect $ closePool pool
          ok "Guest added"

router { body, method: Put, path }
  | path !@ 0 == "guest" && path !@ 1 == "updateGuest" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest "Last parameter is not a valid id (not an integer)"
            Just id -> do
              requestBody <- toString body
              let parsedBody = readGuestJson requestBody
              case parsedBody of
                Nothing -> badRequest "The request body is not a valid guest"
                Just guest -> do
                  flip withPool pool \conn -> updateGuest id guest conn
                  liftEffect $ closePool pool
                  ok $ "Guest with id: " <> show id <> " updated"

router { method: Delete, path }
  | path !@ 0 == "guest" && path !@ 1 == "deleteGuest" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest "Last parameter is not a valid id (not an integer)"
            Just id -> do
              flip withPool pool \conn -> deleteGuest id conn
              liftEffect $ closePool pool
              ok $ "Guest with id: " <> show id <> " deleted"

router _ = notFound

port :: Int
port = 3000

main :: Effect Unit
main = do

  shutdown <- serve port router $ log $ "Server up running on port: " <> show port
  let shutdownServer = do
        log "Shutting down server..."
        shutdown $ log "Server shutdown."
  onSignal SIGINT shutdownServer
  onSignal SIGTERM shutdownServer
  
    --launchAff_ do

      --pool <- liftEffect $ createPool connectionInfo defaultPoolInfo

      --flip withPool pool \conn -> do

        {-liftEffect $ serve port router $ log $ "Server up running on port: " <> show port
          where
            router :: Request -> ResponseM
            router { method: Get, path: [ "guests/getAll" ] } = ok "valami" do
              guests <- getGuests conn
              ok $ writeJSON guests
            router { path: [ "goodbye" ] } = ok "valami"
            router _ = notFound-}
        
        --makeAff
        --let guest = Guest { bdate: "2004/11/22", email: "valami2@valid.email", gender: "male", id: 1, name: "Bence", phone: "+36301234567" }
        --insertGuest guest conn
        --guests <- getGuests conn
        --updateGuest 5 guest conn
        --deleteGuest id conn
        --log $ writeJSON guests

      --liftEffect $ closePool pool