module Style where

import Miso.String
import Clay
import Css.Extra

css :: MisoString
css = mshow . render $ do
    class' "template1" $ do
        pure ()

    class' "template2" $ do
        pure ()