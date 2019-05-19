module Main where

import           Language.Javascript.JSaddle.Warp as JSaddle
import           Miso

import qualified Style.Global
import           Types

import qualified View.Header

update' :: Event -> Model -> Effect Event Model
update' event model = case event of
    NoEvent -> noEff model
    Inc     -> noEff $ model { counter = succ model.counter }

view' :: Model -> View Event
view' model = div_ []
    [ Style.Global.css
    , View.Header.render model
    ]

main :: IO ()
main = putStrLn "Working on http://localhost:8000" >>= \_ -> JSaddle.run 8000 . startApp $ App
    { initialAction = NoEvent
    , model         = defaultModel
    , update        = update'
    , view          = view'
    , events        = defaultEvents
    , subs          = []
    , mountPoint    = Nothing
    }
