module Css.Extra where

import           Clay
import           Data.Text as Text
import           Miso
import           Miso.String as MisoString

mshow :: ToMisoString a => a -> MisoString
mshow = MisoString.ms

class' :: Text -> Css -> Css
class' = (?) . element . (<>) "."

stylify :: Css -> View a
stylify x = nodeHtml "style" [] [ text . mshow $ render x ]

padding1 :: Size LengthUnit -> Css
padding1 x = padding x x x x

margin1 :: Size LengthUnit -> Css
margin1 x = margin x x x x

fontMinMax :: Float -> Float -> Css
fontMinMax minPxSize maxPxSize = "font-size" -: mconcat [ "calc("
                                                        , Text.pack $ show minPxSize
                                                        , "px + ("
                                                        , Text.pack $ show maxPxSize
                                                        , " - "
                                                        , Text.pack $ show minPxSize
                                                        , ") * ((80vw - 500px) / (1600 - 300)))"
                                                        ]