module GymService.Connection.Server where

import Prelude (bind, discard, flip, pure, show, unit, ($), (&&), (+), (-), (<>), (==), (>))

import GymService.Connection.DB (connectionInfo)
import GymService.Persistence.GuestPersist (deleteGuest, findGuest, getActiveGuests, getGuests, getInactiveGuests, getLastGuestId, insertGuest, updateGuest)
import GymService.Persistence.ClubMemberPersist (deleteClubMember, findClubMember, getLastClubMemberId, insertClubMember)
import GymService.Persistence.MembershipPersist (deleteMembership, findMembership, getLastMemberId, getOccasionsLeft, insertMembership, setOccasions)
import GymService.Persistence.MembershipTypePersist (findMembershipType, getMembershipTypes)
import GymService.Persistence.LockerPersist (findLocker, freeupLocker, getFreeGenderLocker, getLockers, occupyLocker)
import GymService.Persistence.GuestLockerPersist (deleteGuestLocker, endGuestLocker, findGuestLocker, getLastGuestLockerId, getUsedGuestLockers, insertGuestLocker)
import GymService.Types.Guest (readGuestJson, readCheckinJson, readCheckoutJson)
import GymService.Types.ClubMember (readClubMemberJson)
import GymService.Types.Membership (readMembershipJson)
import GymService.Types.GuestLocker (GuestLocker(..))

import HTTPure (Method(Get, Post, Put, Delete, Options), Request, ResponseM, badRequest', notFound', ok',(!!), (!@), toString)
import HTTPure.Headers (Headers, header, headers)
import MySQL.Pool (withPool, closePool, createPool, defaultPoolInfo)
import Data.Array (length, index)
import Data.Int (fromString)
import Data.Tuple (Tuple(..))
import Data.Maybe (Maybe(Nothing, Just))
import Effect.Class (liftEffect)
import Simple.JSON (writeJSON)
  
corsHeader :: Headers
corsHeader = header "Access-Control-Allow-Origin" "*"

corsMethodsHeaders :: Headers
corsMethodsHeaders = headers [ Tuple "Access-Control-Allow-Methods" "OPTIONS, GET, HEAD, POST, DELETE, PUT", Tuple "Access-Control-Allow-Origin" "*", Tuple "Access-Control-Allow-Headers" "*"]

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
              flip withPool pool \conn -> do
                deleteGuestLocker id conn
                deleteClubMember id conn
                deleteMembership id conn
                deleteGuest id conn
                liftEffect $ closePool pool
                ok' corsHeader $ wrapMessageinJSON $ "Guest with id: " <> show id <> " deleted"

router { method: Get, path: [ "guest", "getActive" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  activeGuests <- flip withPool pool \conn -> getActiveGuests conn
  liftEffect $ closePool pool
  ok' corsHeader $ writeJSON activeGuests

router { method: Get, path } 
  | path !@ 0 == "guest" && path !@ 1 == "getInactive" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let lastParam = path !! 2
      case lastParam of
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing date parameter"
        Just date -> do
          inactiveGuests <- flip withPool pool \conn -> getInactiveGuests date conn
          liftEffect $ closePool pool
          ok' corsHeader $ writeJSON inactiveGuests

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
  | path !@ 0 == "membership" && path !@ 1 == "findMembershipsById" && length path == 3 = do
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

router { method: Get, path: [ "membership", "getLastId" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  lastId <- flip withPool pool \conn -> getLastMemberId conn
  liftEffect $ closePool pool
  ok' corsHeader $ writeJSON lastId

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

router { method: Get, path: [ "membershipType", "getAll" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  membershipTypes <- flip withPool pool \conn -> getMembershipTypes conn
  liftEffect $ closePool pool
  ok' corsHeader $ writeJSON membershipTypes

router { body, method: Post, path }
  | path !@ 0 == "membership" && path !@ 1 == "insertMembership" = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      requestBody <- toString body
      let parsedBody = readMembershipJson requestBody
      case parsedBody of
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "The request body is not a valid membership"
        Just membership -> do
          flip withPool pool \conn -> insertMembership membership conn
          liftEffect $ closePool pool
          ok' corsHeader $ wrapMessageinJSON "Membership added"

router { method: Get, path: [ "locker", "getAll" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  lockers <- flip withPool pool \conn -> getLockers conn
  liftEffect $ closePool pool
  ok' corsHeader $ writeJSON lockers

router { method: Get, path }
  | path !@ 0 == "locker" && path !@ 1 == "get" && length path == 4 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let thirdParam = path !! 2
      case thirdParam of
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing gender parameter"
        Just gender -> do
          let lastParam = path !! 3
          case lastParam of
            Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing id parameter"
            Just idParam -> do
              let idValue = fromString idParam
              case idValue of
                Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Last parameter is not a valid id (not an integer)"
                Just id -> do
                  locker <- flip withPool pool \conn -> findLocker gender id conn
                  liftEffect $ closePool pool
                  ok' corsHeader $ writeJSON locker

router { method: Get, path: [ "guestlocker", "getUsedGuestLockers" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  usedGuestLockers <- flip withPool pool \conn -> getUsedGuestLockers conn
  liftEffect $ closePool pool
  ok' corsHeader $ writeJSON usedGuestLockers

router { method: Get, path }
  | path !@ 0 == "guestLocker" && path !@ 1 == "getHistory" && length path == 4 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let thirdParam = path !! 2
      case thirdParam of
        Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing gender parameter"
        Just gender -> do
          let lastParam = path !! 3
          case lastParam of
            Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Missing id parameter"
            Just idParam -> do
              let idValue = fromString idParam
              case idValue of
                Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Last parameter is not a valid id (not an integer)"
                Just id -> do
                  lockerHistory <- flip withPool pool \conn -> findGuestLocker gender id conn
                  liftEffect $ closePool pool
                  ok' corsHeader $ writeJSON lockerHistory

router { body, method: Post, path: ["guest", "checkin"]} = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  requestBody <- toString body
  let parsedBody = readCheckinJson requestBody
  case parsedBody of
    Nothing -> badRequest' corsHeader $ wrapMessageinJSON "The request body is not a valid checkin object"
    Just checkin -> do
      flip withPool pool \conn -> do
        result <- getFreeGenderLocker checkin.gender conn
        let singleResult = index result 0
        case singleResult of
          Nothing -> badRequest' corsHeader $ wrapMessageinJSON "No free locker left"
          Just freeLocker -> do
            lastGuestLocker <- getLastGuestLockerId conn
            let newId = index lastGuestLocker 0
            case newId of
              Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Cannot get guestlocker ID"
              Just id -> do
                let targetId = id.lastId + 1
                let start = checkin.date <> " " <> checkin.time
                let guestLocker = GuestLocker { id: targetId, guestId: checkin.guestId, lockerId: freeLocker.id, lockerGender: checkin.gender, startTime: start, endTime: "0"}
                insertGuestLocker guestLocker conn
                occupyLocker freeLocker.id checkin.gender conn
                remainingOccasionsArray <- getOccasionsLeft checkin.guestId checkin.date conn
                let remainingOccasionsCandidate = index remainingOccasionsArray 0
                case remainingOccasionsCandidate of
                  Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Cannot get guestlocker remaining occasions"
                  Just remainingOccasions -> do
                    if remainingOccasions.occasionsLeft > 0
                    then setOccasions (remainingOccasions.occasionsLeft - 1) remainingOccasions.id conn
                    else pure unit
                    liftEffect $ closePool pool
                    ok' corsHeader $ wrapMessageinJSON "Check-in successful"

router { body, method: Post, path: ["guest", "checkout"]} = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  requestBody <- toString body
  let parsedBody = readCheckoutJson requestBody
  case parsedBody of
    Nothing -> badRequest' corsHeader $ wrapMessageinJSON "The request body is not a valid checkout object"
    Just checkout -> do
      flip withPool pool \conn -> do
        endGuestLocker checkout.dateTime checkout.guestId checkout.lockerId checkout.gender conn
        freeupLocker checkout.lockerId checkout.gender conn
        liftEffect $ closePool pool
        ok' corsHeader $ wrapMessageinJSON "Check-out successful"

router { method: Options } = do
  ok' corsMethodsHeaders "ok"

router _ = notFound' corsHeader

port :: Int
port = 3000