module Main where

import           Language.Javascript.JSaddle.Warp as JSaddle
import           Miso

import qualified Style.Global
import           Types

import qualified Miso.Styled.Html as Styled
import           View.Header
import           View.TODO
import Clay

update' :: Event -> Model -> Effect Event Model
update' event model = case event of
    NoEvent -> noEff model
    Inc     -> noEff $ model { counter = succ model.counter }

view' :: Model -> View Event
view' _model = div_ []
    -- [ Style.Global.css
    -- , View.Header.render model
    -- , View.TODO.render model
    -- ]
    [ Styled.toUnstyled $ Styled.node "div" []
        [ Styled.text "testa"
        , title [] [ Styled.text "Styled title another exemple" ]
        , Styled.node "h1" [ Styled.class_ "tek" ] [ Styled.text "kek" ]
        , title [] [ Styled.text "Styled title" ]
        , btn [] [ Styled.text "Click me" ]
        ]
    ]
  where
    title = Styled.styled "h1" "title" $ do
        color "#e32"

    btn = Styled.styled "div" "btn" $ do
        border solid (px 2) "#000000"
        borderRadius (px 1) (px 1) (px 1) (px 1)
        height $ px 50
        width $ px 150

        hover & do transform $ scale 1.2 1.2

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
