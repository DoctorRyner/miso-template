module Miso.Styled.Html where

import qualified Miso
import Miso.String hiding (map)
-- import Clay hiding (map)

mshow :: ToMisoString a => a -> MisoString
mshow = Miso.String.ms

data VTree a = VNode String [Attribute a] [VTree a] | VText String

data Attribute a = Attribute (Miso.Attribute a)
data View a = View (Miso.View a)

-- text :: String -> View a
-- text = View . Miso.text . mshow

-- node :: String -> [Attribute a] -> [View a] -> View a
-- node tag attrs childs = node tag attrs childs

toUnstyledAttribute :: Attribute a -> Miso.Attribute a
toUnstyledAttribute (Attribute attr) = attr

text :: String -> VTree a
text = VText

node :: String -> [Attribute a] -> [VTree a] -> VTree a
node = VNode

toUnstyled :: VTree a -> Miso.View a
toUnstyled (VText str) = Miso.text $ mshow str
toUnstyled (VNode tag attrs childs) = Miso.nodeHtml
    (mshow tag)
    (map toUnstyledAttribute attrs)
    (map toUnstyled childs)

class_ :: String -> Attribute a
class_ = Attribute . Miso.class_ . mshow