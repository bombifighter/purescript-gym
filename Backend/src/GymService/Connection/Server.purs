module GymService.Connection.Server where

import GymService.Connection.DB
import GymService.Persistence.GuestPersist
import GymService.Persistence.ClubMemberPersist
import GymService.Persistence.MembershipPersist
import GymService.Persistence.MembershipTypePersist
import GymService.Persistence.LockerPersist
import GymService.Persistence.GuestLockerPersist
import GymService.Types.Guest
import GymService.Types.ClubMember
import GymService.Types.Membership
import GymService.Types.MembershipType
import GymService.Types.Locker
import GymService.Types.GuestLocker
import Prelude

import HTTPure (Method(Get, Post, Put, Delete, Options), Request, ResponseM, badRequest', notFound', ok',(!!), (!@), toString)
import HTTPure.Headers (Headers, header, headers)
import MySQL.Connection (ConnectionInfo)
import MySQL.Pool (withPool, closePool, createPool, defaultPoolInfo)
import Simple.JSON (writeJSON)
import Data.Array (length, index)
import Data.Int (fromString)
import Data.Tuple (Tuple(..))
import Data.Maybe (Maybe(Nothing, Just))
import Effect.Class (liftEffect)
import Data.Either (Either(Left, Right), either, fromRight)
import Data.String as String
import Data.DateTime
import Data.DateTime.Instant
import Data.Formatter.DateTime (formatDateTime)
import Partial.Unsafe (unsafePartial)
import Effect.Now (nowDateTime)
import Effect.Aff
import Effect
import Effect.Unsafe
import Effect.Class.Console (log)

calculateTodayDate :: String
calculateTodayDate = do
  let date = unsafePerformEffect nowDateTime
  let formatted = formatDateTime "YYYY/MM/DD" date
  case formatted of
    Left e -> e
    Right d -> d

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

router { method: Get, path: [ "guest", "getActive" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  activeGuests <- flip withPool pool \conn -> getActiveGuests conn
  liftEffect $ closePool pool
  ok' corsHeader $ writeJSON activeGuests

router { method: Get, path }
  | path !@ 0 == "guest" && path !@ 1 == "getInactive" && length path == 3 = do
      pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
      let dateParam = path !! 2
      case dateParam of
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

router { method: Get, path: [ "member", "getLastId" ] } = do
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

router { method: Get, path: [ "membershipTypes", "getAll" ] } = do
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

router { method: Get, path: [ "lockers", "getAll" ] } = do
  pool <- liftEffect $ createPool connectionInfo defaultPoolInfo
  lockers <- flip withPool pool \conn -> getLockers conn
  liftEffect $ closePool pool
  ok' corsHeader $ writeJSON lockers

router { method: Get, path }
  | path !@ 0 == "lockers" && path !@ 1 == "get" && length path == 4 = do
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
        log $ "Checkin gender: " <> show checkin.gender -- EDDIG JÓ
        result <- getFreeGenderLocker checkin.gender conn
        log $ "Result: " <> show result
        let singleResult = index result 0
        log $ "Single result: " <> show singleResult
        case singleResult of
          Nothing -> badRequest' corsHeader $ wrapMessageinJSON "No free locker left"
          Just freeLocker -> do
            lastId <- getLastGuestLockerId conn
            log $ "Last guestlocker ID: " <> show lastId
            let newId = index lastId 0
            log $ "Single guestlocker ID: " <> show newId
            case newId of
              Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Cannot get guestlocker ID"
              Just id -> do
                let targetId = id + 1
                let guestLocker = GuestLocker { id: targetId, guestId: checkin.guestId, lockerId: freeLocker, lockerGender: checkin.gender, startTime: checkin.time, endTime: "0"}
                insertGuestLocker guestLocker conn
                occupyLocker freeLocker checkin.gender conn
                let now = calculateTodayDate
                remainingOccasionsArray <- getOccasionsLeft checkin.guestId now conn
                let remainingOccasionsCandidate = index remainingOccasionsArray 0
                case remainingOccasionsCandidate of
                  Nothing -> badRequest' corsHeader $ wrapMessageinJSON "Cannot get guestlocker remaining occasions"
                  Just remainingOccasions -> do
                    if remainingOccasions.occasionsLeft > 0
                    then setOccasions (remainingOccasions.occasionsLeft - 1) remainingOccasions.id conn
                    else pure unit
                    liftEffect $ closePool pool
                    ok' corsHeader "Checkin successful"


router { method: Options } = do
  ok' corsMethodsHeaders "ok"

router _ = notFound' corsHeader

port :: Int
port = 3000