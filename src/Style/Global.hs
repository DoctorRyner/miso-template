module Style.Global where

import           Css.Extra
import           Miso

css :: View a
css = stylify $
    star ? do
        padding1 $ px 0
        margin1  $ px 0
