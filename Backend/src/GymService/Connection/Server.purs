module GymService.Connection.Server where

import GymService.Persistence.GuestPersist
import GymService.Connection.DB
import GymService.Types.Guest
import Prelude

import HTTPure (Method(Get, Post, Put, Delete), Request, ResponseM, badRequest', notFound', ok',(!!), (!@), toString)
import HTTPure.Headers (Headers, header)
import MySQL.Connection (ConnectionInfo)
import MySQL.Pool (withPool, closePool, createPool, defaultPoolInfo)
import Simple.JSON (writeJSON)
import Data.Array (length)
import Data.Int (fromString)
import Data.Maybe (Maybe(Nothing, Just))
import Effect.Class (liftEffect)


corsHeader :: Headers
corsHeader = header "Access-Control-Allow-Origin" "*"

router :: Request -> ResponseM
router { method: Get, path: [ "guest", "getAll" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  guests <- flip withPool pool \conn -> getGuests conn
  liftEffect $ closePool pool
  ok' corsHeader $ writeJSON guests

router { method: Get, path }
  | path !@ 0 == "guest" && path !@ 1 == "getById" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest' corsHeader "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest' corsHeader "Last parameter is not a valid id (not an integer)"
            Just id -> do
              guest <- flip withPool pool \conn -> findGuest id conn
              liftEffect $ closePool pool
              ok' corsHeader $ writeJSON guest

router { body, method: Post, path }
  | path !@ 0 == "guest" && path !@ 1 == "insertGuest" = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      requestBody <- toString body
      let parsedBody = readGuestJson requestBody
      case parsedBody of
        Nothing -> badRequest' corsHeader "The request body is not a valid guest"
        Just guest -> do
          flip withPool pool \conn -> insertGuest guest conn
          liftEffect $ closePool pool
          ok' corsHeader "Guest added"

router { body, method: Put, path }
  | path !@ 0 == "guest" && path !@ 1 == "updateGuest" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest' corsHeader "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest' corsHeader "Last parameter is not a valid id (not an integer)"
            Just id -> do
              requestBody <- toString body
              let parsedBody = readGuestJson requestBody
              case parsedBody of
                Nothing -> badRequest' corsHeader "The request body is not a valid guest"
                Just guest -> do
                  flip withPool pool \conn -> updateGuest id guest conn
                  liftEffect $ closePool pool
                  ok' corsHeader $ "Guest with id: " <> show id <> " updated"

router { method: Delete, path }
  | path !@ 0 == "guest" && path !@ 1 == "deleteGuest" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest' corsHeader "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest' corsHeader "Last parameter is not a valid id (not an integer)"
            Just id -> do
              flip withPool pool \conn -> deleteGuest id conn
              liftEffect $ closePool pool
              ok' corsHeader $ "Guest with id: " <> show id <> " deleted"

router _ = notFound' corsHeader

port :: Int
port = 3000