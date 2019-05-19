module Types where

data Event
    = NoEvent
    deriving (Eq, Show)

data Model = Model { counter :: Int } deriving Eq

defaultModel :: Model
defaultModel = Model { counter = 0 }