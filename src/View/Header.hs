module View.Header where

import           Css.Extra
import           Miso
import           Types

css :: View a
css = stylify $ do
    class' "header" $ do
        height $ px 70
        width  $ pct 100
        backgroundColor "#4E9EFF"

render :: Model -> View Event
render model = div_ [ class_ "header" ]
    [ css
    , label_ [ onClick Inc ] [ text $ mshow model.counter ]
    ]
