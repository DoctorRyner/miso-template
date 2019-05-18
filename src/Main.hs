module Main where

import Miso
import Miso.String
import Language.Javascript.JSaddle.Warp as JSaddle

type Model = Int

defaultModel :: Model
defaultModel = 0

data Event
    = NoEvent
    | Inc
    deriving (Eq, Show)

update' :: Event -> Model -> Effect Event Model
update' event model = case event of
    NoEvent -> noEff model
    Inc     -> noEff $ succ model

view' :: Model -> View Event
view' model = div_ []
    [ text $ ms model
    , button_ [ onClick Inc ] [ text "+" ]
    ]

main :: IO ()
main = putStrLn "Working on http://localhost:8000" >>= \_ -> JSaddle.run 8000 $ startApp App {..}
  where
    initialAction = NoEvent
    model  = defaultModel
    update = update'
    view   = view'
    events = defaultEvents
    subs   = []
    mountPoint = Nothing