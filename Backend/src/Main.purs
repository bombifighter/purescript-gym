module Main where

import GymService.Connection.Server (port, router)
import Prelude (Unit, bind, discard, show, ($), (<>))

import Data.Posix.Signal (Signal(SIGINT, SIGTERM))
import Effect (Effect)
import Effect.Class.Console (log)
import HTTPure (serve)
import Node.Process (onSignal)


main :: Effect Unit
main = do
  shutdown <- serve port router $ log $ "Server up running on port: " <> show port
  let shutdownServer = do
        log "Shutting down server..."
        shutdown $ log "Server shutdown."
  onSignal SIGINT shutdownServer
  onSignal SIGTERM shutdownServer
