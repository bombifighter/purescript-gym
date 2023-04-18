module GymService.Connection.Server where

import GymService.Connection.DB
import GymService.Persistence.GuestPersist
import GymService.Persistence.ClubMemberPersist
import GymService.Persistence.MembershipPersist
import GymService.Persistence.MembershipTypePersist
import GymService.Types.Guest
import GymService.Types.ClubMember
import GymService.Types.Membership
import GymService.Types.MembershipType
import Prelude

import HTTPure (Method(Get, Post, Put, Delete, Options), Request, ResponseM, badRequest', notFound', ok',(!!), (!@), toString)
import HTTPure.Headers (Headers, header, headers)
import MySQL.Connection (ConnectionInfo)
import MySQL.Pool (withPool, closePool, createPool, defaultPoolInfo)
import Simple.JSON (writeJSON)
import Data.Array (length)
import Data.Int (fromString)
import Data.Tuple (Tuple(..))
import Data.Maybe (Maybe(Nothing, Just))
import Effect.Class (liftEffect)


corsHeader :: Headers
corsHeader = header "Access-Control-Allow-Origin" "*"

corsMethodsHeaders :: Headers
corsMethodsHeaders = headers [ Tuple "Access-Control-Allow-Methods" "OPTIONS, GET, HEAD, POST, DELETE, PUT", Tuple "Access-Control-Allow-Origin" "*"]

wrapMessageinJSON :: String -> String
wrapMessageinJSON message = "{\"message\":\"" <> message <> "\"}"

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
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Last parameter is not a valid id (not an integer)"
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
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "The request body is not a valid guest"
        Just guest -> do
          flip withPool pool \conn -> insertGuest guest conn
          liftEffect $ closePool pool
          ok' corsHeader $ wrapMessageinJSON "Guest added"

router { body, method: Put, path }
  | path !@ 0 == "guest" && path !@ 1 == "updateGuest" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Last parameter is not a valid id (not an integer)"
            Just id -> do
              requestBody <- toString body
              let parsedBody = readGuestJson requestBody
              case parsedBody of
                Nothing -> badRequest' corsHeader $ wrapMessageinJSON "The request body is not a valid guest"
                Just guest -> do
                  flip withPool pool \conn -> updateGuest id guest conn
                  liftEffect $ closePool pool
                  ok' corsHeader $ wrapMessageinJSON $ "Guest with id: " <> show id <> " updated"

router { method: Delete, path }
  | path !@ 0 == "guest" && path !@ 1 == "deleteGuest" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Last parameter is not a valid id (not an integer)"
            Just id -> do
              flip withPool pool \conn -> deleteGuest id conn
              liftEffect $ closePool pool
              ok' corsHeader $ wrapMessageinJSON $ "Guest with id: " <> show id <> " deleted"

router { method: Get, path: [ "guest", "getLastId" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  guestId <- flip withPool pool \conn -> getLastGuestId conn
  liftEffect $ closePool pool
  ok' corsHeader $ writeJSON guestId

router { method: Get, path }
  | path !@ 0 == "clubmember" && path !@ 1 == "findMembershipsById" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Last parameter is not a valid id (not an integer)"
            Just id -> do
              clubMemberships <- flip withPool pool \conn -> findClubMember id conn
              liftEffect $ closePool pool
              ok' corsHeader $ writeJSON clubMemberships

router { method: Get, path }
  | path !@ 0 == "member" && path !@ 1 == "findMembershipsById" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Last parameter is not a valid id (not an integer)"
            Just id -> do
              memberships <- flip withPool pool \conn -> findMembership id conn
              liftEffect $ closePool pool
              ok' corsHeader $ writeJSON memberships

router { method: Get, path }
  | path !@ 0 == "membershipType" && path !@ 1 == "getMembershipById" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing id parameter"
        Just idParam -> do
          let idValue = fromString idParam
          case idValue of
            Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Last parameter is not a valid id (not an integer)"
            Just id -> do
              membershipType <- flip withPool pool \conn -> findMembershipType id conn
              liftEffect $ closePool pool
              ok' corsHeader $ writeJSON membershipType

router { method: Get, path: [ "clubmember", "getLastId" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  lastId <- flip withPool pool \conn -> getLastClubMemberId conn
  liftEffect $ closePool pool
  ok' corsHeader $ writeJSON lastId

router { body, method: Post, path }
  | path !@ 0 == "clubmember" && path !@ 1 == "insertClubMember" = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      requestBody <- toString body
      let parsedBody = readClubMemberJson requestBody
      case parsedBody of
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "The request body is not a valid clubmember"
        Just clubMember -> do
          flip withPool pool \conn -> insertClubMember clubMember conn
          liftEffect $ closePool pool
          ok' corsHeader $ wrapMessageinJSON "Clubmember added"

router { method: Options } = do
  ok' corsMethodsHeaders "ok"

router _ = notFound' corsHeader

port :: Int
port = 3000