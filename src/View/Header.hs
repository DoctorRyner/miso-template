module View.Header where

import           Css.Extra
import           Miso
import           Types

css :: View a
css = stylify $ do
    class' "header" $ do
        height $ vh 10
        width  $ pct 100
        backgroundColor "#4E9EFF"
        display flex

    class' "header-title" $ do
        width $ pct 100
        color white
        textAlign center
        alignSelf center
        fontMinMax 12 60

render :: Model -> View Event
render model = div_ [ class_ "header" ]
    [ css
    , label_ [ onClick Inc, class_ "header-title" ] [ text "TODO App" ]
    ]
