module Main where

import           Control.Monad.IO.Class
import           Language.Javascript.JSaddle.Warp as JSaddle
import           Miso
import           Miso.String
import qualified Style

data Model = Model
    {
    } deriving Eq

defaultModel :: Model
defaultModel = Model

data Event
    = NoEvent
    deriving (Eq, Show)

update' :: Event -> Model -> Effect Event Model
update' event model = case event of
    NoEvent -> noEff model

view' :: Model -> View Event
view' model = div_ []
    [ nodeHtml "style" [] [ text Style.css ]
    , text "Hello ~ Haskell GUI"
    ]

main :: IO ()
main = do
    putStrLn "Working on http://localhost:8000"

    JSaddle.debug 8000 . startApp $ App { initialAction = NoEvent
                                        , model         = defaultModel
                                        , update        = update'
                                        , view          = view'
                                        , events        = defaultEvents
                                        , subs          = []
                                        , mountPoint    = Nothing
                                        }
