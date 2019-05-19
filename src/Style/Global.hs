module Style.Global where

import           Css.Extra
import           Miso

css :: View a
css = stylify $ do
    importUrl "https://fonts.googleapis.com/css?family=Roboto&display=swap"
    
    star ? do
        padding1 $ px 0
        margin1  $ px 0
        fontFamily [ "Roboto" ] [ sansSerif ]

    body ? do
        height $ pct 100
        width  $ pct 100
