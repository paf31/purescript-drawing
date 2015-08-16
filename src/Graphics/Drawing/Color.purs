-- | This module defines preset colors, and functions for creating colors.

module Graphics.Drawing.Color 
  ( Color()
  
  , colorString
  
  , aliceBlue
  , antiqueWhite
  , aqua
  , aquamarine
  , azure
  , beige
  , bisque
  , black
  , blanchedAlmond
  , blue
  , blueViolet
  , brown
  , burlyWood
  , cadetBlue
  , chartreuse
  , chocolate
  , coral
  , cornflowerBlue
  , cornsilk
  , crimson
  , cyan
  , darkBlue
  , darkCyan
  , darkGoldenRod
  , darkGray
  , darkGreen
  , darkKhaki
  , darkMagenta
  , darkOliveGreen
  , darkOrange
  , darkOrchid
  , darkRed
  , darkSalmon
  , darkSeaGreen
  , darkSlateBlue
  , darkSlateGray
  , darkTurquoise
  , darkViolet
  , deepPink
  , deepSkyBlue
  , dimGray
  , dodgerBlue
  , fireBrick
  , floralWhite
  , forestGreen
  , fuchsia
  , gainsboro
  , ghostWhite
  , gold
  , goldenRod
  , gray
  , green
  , greenYellow
  , honeyDew
  , hotPink
  , indianRed 
  , indigo 
  , ivory
  , khaki
  , lavender
  , lavenderBlush
  , lawnGreen
  , lemonChiffon
  , lightBlue
  , lightCoral
  , lightCyan
  , lightGoldenRodYellow
  , lightGray
  , lightGreen
  , lightPink
  , lightSalmon
  , lightSeaGreen
  , lightSkyBlue
  , lightSlateGray
  , lightSteelBlue
  , lightYellow
  , lime
  , limeGreen
  , linen
  , magenta
  , maroon
  , mediumAquaMarine
  , mediumBlue
  , mediumOrchid
  , mediumPurple
  , mediumSeaGreen
  , mediumSlateBlue
  , mediumSpringGreen
  , mediumTurquoise
  , mediumVioletRed
  , midnightBlue
  , mintCream
  , mistyRose
  , moccasin
  , navajoWhite
  , navy
  , oldLace
  , olive
  , oliveDrab
  , orange
  , orangeRed
  , orchid
  , paleGoldenRod
  , paleGreen
  , paleTurquoise
  , paleVioletRed
  , papayaWhip
  , peachPuff
  , peru
  , pink
  , plum
  , powderBlue
  , purple
  , rebeccaPurple
  , red
  , rosyBrown
  , royalBlue
  , saddleBrown
  , salmon
  , sandyBrown
  , seaGreen
  , seaShell
  , sienna
  , silver
  , skyBlue
  , slateBlue
  , slateGray
  , snow
  , springGreen
  , steelBlue
  , tan
  , teal
  , thistle
  , tomato
  , turquoise
  , violet
  , wheat
  , white
  , whiteSmoke
  , yellow
  , yellowGreen
  ) where

-- | Colors.
newtype Color = Color String

-- | Render a color as a HTML color string.
colorString :: Color -> String
colorString (Color c) = c

aliceBlue :: Color
aliceBlue = Color "aliceBlue"

antiqueWhite :: Color
antiqueWhite = Color "antiqueWhite"

aqua :: Color
aqua = Color "aqua"

aquamarine :: Color
aquamarine = Color "aquamarine"

azure :: Color
azure = Color "azure"

beige :: Color
beige = Color "beige"

bisque :: Color
bisque = Color "bisque"

black :: Color
black = Color "black"

blanchedAlmond :: Color
blanchedAlmond = Color "blanchedAlmond"

blue :: Color
blue = Color "blue"

blueViolet :: Color
blueViolet = Color "blueViolet"

brown :: Color
brown = Color "brown"

burlyWood :: Color
burlyWood = Color "burlyWood"

cadetBlue :: Color
cadetBlue = Color "cadetBlue"

chartreuse :: Color
chartreuse = Color "chartreuse"

chocolate :: Color
chocolate = Color "chocolate"

coral :: Color
coral = Color "coral"

cornflowerBlue :: Color
cornflowerBlue = Color "cornflowerBlue"

cornsilk :: Color
cornsilk = Color "cornsilk"

crimson :: Color
crimson = Color "crimson"

cyan :: Color
cyan = Color "cyan"

darkBlue :: Color
darkBlue = Color "darkBlue"

darkCyan :: Color
darkCyan = Color "darkCyan"

darkGoldenRod :: Color
darkGoldenRod = Color "darkGoldenRod"

darkGray :: Color
darkGray = Color "darkGray"

darkGreen :: Color
darkGreen = Color "darkGreen"

darkKhaki :: Color
darkKhaki = Color "darkKhaki"

darkMagenta :: Color
darkMagenta = Color "darkMagenta"

darkOliveGreen :: Color
darkOliveGreen = Color "darkOliveGreen"

darkOrange :: Color
darkOrange = Color "darkOrange"

darkOrchid :: Color
darkOrchid = Color "darkOrchid"

darkRed :: Color
darkRed = Color "darkRed"

darkSalmon :: Color
darkSalmon = Color "darkSalmon"

darkSeaGreen :: Color
darkSeaGreen = Color "darkSeaGreen"

darkSlateBlue :: Color
darkSlateBlue = Color "darkSlateBlue"

darkSlateGray :: Color
darkSlateGray = Color "darkSlateGray"

darkTurquoise :: Color
darkTurquoise = Color "darkTurquoise"

darkViolet :: Color
darkViolet = Color "darkViolet"

deepPink :: Color
deepPink = Color "deepPink"

deepSkyBlue :: Color
deepSkyBlue = Color "deepSkyBlue"

dimGray :: Color
dimGray = Color "dimGray"

dodgerBlue :: Color
dodgerBlue = Color "dodgerBlue"

fireBrick :: Color
fireBrick = Color "fireBrick"

floralWhite :: Color
floralWhite = Color "floralWhite"

forestGreen :: Color
forestGreen = Color "forestGreen"

fuchsia :: Color
fuchsia = Color "fuchsia"

gainsboro :: Color
gainsboro = Color "gainsboro"

ghostWhite :: Color
ghostWhite = Color "ghostWhite"

gold :: Color
gold = Color "gold"

goldenRod :: Color
goldenRod = Color "goldenRod"

gray :: Color
gray = Color "gray"

green :: Color
green = Color "green"

greenYellow :: Color
greenYellow = Color "greenYellow"

honeyDew :: Color
honeyDew = Color "honeyDew"

hotPink :: Color
hotPink = Color "hotPink"

indianRed  :: Color
indianRed  = Color "indianRed "

indigo  :: Color
indigo  = Color "indigo "

ivory :: Color
ivory = Color "ivory"

khaki :: Color
khaki = Color "khaki"

lavender :: Color
lavender = Color "lavender"

lavenderBlush :: Color
lavenderBlush = Color "lavenderBlush"

lawnGreen :: Color
lawnGreen = Color "lawnGreen"

lemonChiffon :: Color
lemonChiffon = Color "lemonChiffon"

lightBlue :: Color
lightBlue = Color "lightBlue"

lightCoral :: Color
lightCoral = Color "lightCoral"

lightCyan :: Color
lightCyan = Color "lightCyan"

lightGoldenRodYellow :: Color
lightGoldenRodYellow = Color "lightGoldenRodYellow"

lightGray :: Color
lightGray = Color "lightGray"

lightGreen :: Color
lightGreen = Color "lightGreen"

lightPink :: Color
lightPink = Color "lightPink"

lightSalmon :: Color
lightSalmon = Color "lightSalmon"

lightSeaGreen :: Color
lightSeaGreen = Color "lightSeaGreen"

lightSkyBlue :: Color
lightSkyBlue = Color "lightSkyBlue"

lightSlateGray :: Color
lightSlateGray = Color "lightSlateGray"

lightSteelBlue :: Color
lightSteelBlue = Color "lightSteelBlue"

lightYellow :: Color
lightYellow = Color "lightYellow"

lime :: Color
lime = Color "lime"

limeGreen :: Color
limeGreen = Color "limeGreen"

linen :: Color
linen = Color "linen"

magenta :: Color
magenta = Color "magenta"

maroon :: Color
maroon = Color "maroon"

mediumAquaMarine :: Color
mediumAquaMarine = Color "mediumAquaMarine"

mediumBlue :: Color
mediumBlue = Color "mediumBlue"

mediumOrchid :: Color
mediumOrchid = Color "mediumOrchid"

mediumPurple :: Color
mediumPurple = Color "mediumPurple"

mediumSeaGreen :: Color
mediumSeaGreen = Color "mediumSeaGreen"

mediumSlateBlue :: Color
mediumSlateBlue = Color "mediumSlateBlue"

mediumSpringGreen :: Color
mediumSpringGreen = Color "mediumSpringGreen"

mediumTurquoise :: Color
mediumTurquoise = Color "mediumTurquoise"

mediumVioletRed :: Color
mediumVioletRed = Color "mediumVioletRed"

midnightBlue :: Color
midnightBlue = Color "midnightBlue"

mintCream :: Color
mintCream = Color "mintCream"

mistyRose :: Color
mistyRose = Color "mistyRose"

moccasin :: Color
moccasin = Color "moccasin"

navajoWhite :: Color
navajoWhite = Color "navajoWhite"

navy :: Color
navy = Color "navy"

oldLace :: Color
oldLace = Color "oldLace"

olive :: Color
olive = Color "olive"

oliveDrab :: Color
oliveDrab = Color "oliveDrab"

orange :: Color
orange = Color "orange"

orangeRed :: Color
orangeRed = Color "orangeRed"

orchid :: Color
orchid = Color "orchid"

paleGoldenRod :: Color
paleGoldenRod = Color "paleGoldenRod"

paleGreen :: Color
paleGreen = Color "paleGreen"

paleTurquoise :: Color
paleTurquoise = Color "paleTurquoise"

paleVioletRed :: Color
paleVioletRed = Color "paleVioletRed"

papayaWhip :: Color
papayaWhip = Color "papayaWhip"

peachPuff :: Color
peachPuff = Color "peachPuff"

peru :: Color
peru = Color "peru"

pink :: Color
pink = Color "pink"

plum :: Color
plum = Color "plum"

powderBlue :: Color
powderBlue = Color "powderBlue"

purple :: Color
purple = Color "purple"

rebeccaPurple :: Color
rebeccaPurple = Color "rebeccaPurple"

red :: Color
red = Color "red"

rosyBrown :: Color
rosyBrown = Color "rosyBrown"

royalBlue :: Color
royalBlue = Color "royalBlue"

saddleBrown :: Color
saddleBrown = Color "saddleBrown"

salmon :: Color
salmon = Color "salmon"

sandyBrown :: Color
sandyBrown = Color "sandyBrown"

seaGreen :: Color
seaGreen = Color "seaGreen"

seaShell :: Color
seaShell = Color "seaShell"

sienna :: Color
sienna = Color "sienna"

silver :: Color
silver = Color "silver"

skyBlue :: Color
skyBlue = Color "skyBlue"

slateBlue :: Color
slateBlue = Color "slateBlue"

slateGray :: Color
slateGray = Color "slateGray"

snow :: Color
snow = Color "snow"

springGreen :: Color
springGreen = Color "springGreen"

steelBlue :: Color
steelBlue = Color "steelBlue"

tan :: Color
tan = Color "tan"

teal :: Color
teal = Color "teal"

thistle :: Color
thistle = Color "thistle"

tomato :: Color
tomato = Color "tomato"

turquoise :: Color
turquoise = Color "turquoise"

violet :: Color
violet = Color "violet"

wheat :: Color
wheat = Color "wheat"

white :: Color
white = Color "white"

whiteSmoke :: Color
whiteSmoke = Color "whiteSmoke"

yellow :: Color
yellow = Color "yellow"

yellowGreen :: Color
yellowGreen = Color "yellowGreen"
