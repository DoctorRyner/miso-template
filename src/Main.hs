module Main where

import           Language.Javascript.JSaddle.Warp as JSaddle
import           Miso

import qualified Style.Global
import           Types

update' :: Event -> Model -> Effect Event Model
update' event model = case event of
    NoEvent -> noEff model

view' :: Model -> View Event
view' _model = div_ []
    [ Style.Global.css
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
