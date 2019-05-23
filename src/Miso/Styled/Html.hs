module Miso.Styled.Html where

import qualified Miso
import Miso.String hiding (map)
import Clay hiding (map)
import qualified Css.Extra
import qualified Data.Text as Text

mshow :: ToMisoString a => a -> MisoString
mshow = Miso.String.ms

data VTree a = VNode (String, Css) String [Attribute a] [VTree a] | VText String

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
node = VNode ("", pure ())

styled :: String -> String -> Css -> [Attribute a] -> [VTree a] -> VTree a
styled tag cssTag cssCode = VNode (cssTag, cssCode) tag

collectHtml :: VTree a -> Miso.View a
collectHtml (VText str) = Miso.text $ mshow str
collectHtml (VNode (cssTag, _) tag attrs childs) = Miso.nodeHtml
    (mshow tag)
    (map toUnstyledAttribute attrs ++ [ Miso.class_ $ mshow cssTag ])
    (map collectHtml childs)

collectCss :: VTree a -> [(String, Css)] -> [(String, Css)]
collectCss (VText _) store = store ++ [("", pure ())]
collectCss (VNode cssToCollect _ _ childs) store = mconcat
    [ store
    , [cssToCollect]
    , mconcat $ map (\child -> collectCss child store) childs
    ]

isCssTagUnique :: String -> [(String, Css)] -> Bool
isCssTagUnique _ [] = True
isCssTagUnique cssTag ((cssTagInList, _):xs) = if cssTag == cssTagInList
    then False
    else isCssTagUnique cssTag xs

generateCss :: [(String, Css)] -> [(String, Css)] -> Miso.View a
generateCss [] styles = Miso.nodeHtml "style" []
    [ Miso.text $ mshow $ render $ Prelude.foldr
        (\(cssTag, cssCode) res -> res <> (Css.Extra.class' (Text.pack cssTag) cssCode) )
        (pure ())
        styles
    ]
generateCss ((cssTag, cssCode):xs) styles = if isCssTagUnique cssTag styles
    then generateCss xs (styles ++ [(cssTag, cssCode)])
    else generateCss xs styles
-- generateCss ((cssTag, cssCode):xs) styles = if 

toUnstyled :: VTree a -> Miso.View a
toUnstyled styledTree = Miso.div_ []
    [ Miso.text "Alpha Styled Elements Generation"
    , generateCss (collectCss styledTree []) []
    , collectHtml styledTree
    ]

class_ :: String -> Attribute a
class_ = Attribute . Miso.class_ . mshow