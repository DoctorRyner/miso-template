module Main where

import           Language.Javascript.JSaddle.Warp as JSaddle
import           Miso

import qualified Style.Global
import           Types

import qualified Miso.Styled.Html as Styled
import           View.Header
import           View.TODO

update' :: Event -> Model -> Effect Event Model
update' event model = case event of
    NoEvent -> noEff model
    Inc     -> noEff $ model { counter = succ model.counter }

view' :: Model -> View Event
view' model = div_ []
    -- [ Style.Global.css
    -- , View.Header.render model
    -- , View.TODO.render model
    -- ]
    [ Styled.toUnstyled $ Styled.node "div" []
        [ Styled.text "testa"
        , Styled.node "h1" [ Styled.class_ "tek" ] [ Styled.text "keka" ]
        ]
    ]

main :: IO ()
main = do
    putStrLn "Working on:"

    JSaddle.debug 8000 . startApp $ App { initialAction = NoEvent
                                        , model         = defaultModel
                                        , update        = update'
                                        , view          = view'
                                        , events        = defaultEvents
                                        , subs          = []
                                        , mountPoint    = Nothing
                                        }
