module Main where

import GymService.Connection.Server
import Prelude

import Data.Array (length)
import Data.Int (fromString)
import Data.Maybe (Maybe(Nothing, Just))
import Data.Posix.Signal (Signal(SIGINT, SIGTERM))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import HTTPure (Method(Get, Post, Put, Delete), Request, ResponseM, badRequest, notFound, ok, serve, (!!), (!@), toString)
import MySQL.Pool (withPool, closePool, createPool, defaultPoolInfo)
import Node.Process (onSignal)
import Simple.JSON (writeJSON)


main :: Effect Unit
main = do
  shutdown <- serve port router $ log $ "Server up running on port: " <> show port
  let shutdownServer = do
        log "Shutting down server..."
        shutdown $ log "Server shutdown."
  onSignal SIGINT shutdownServer
  onSignal SIGTERM shutdownServer