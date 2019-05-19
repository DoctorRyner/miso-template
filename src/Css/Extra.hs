module Css.Extra (module Css.Extra, module Clay) where

import           Clay
import           Data.Text
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