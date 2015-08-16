-- | This module defines a type `Drawing` for creating vector graphics.

module Graphics.Drawing 
  ( Point()
  , Shape(), path, closed, rectangle, circle
  , FillStyle(), fillColor
  , OutlineStyle(), outlineColor, lineWidth
  , Drawing(), filled, outlined, clipped, scale, translate, rotate
  , everywhere
  , render
  , module Graphics.Drawing.Color
  ) where
      
import Prelude

import Data.List
import Data.Maybe
import Data.Monoid
import Data.Foldable (Foldable, for_)

import Control.Alt ((<|>))
import Control.Monad (when)

import Control.Monad.Eff

import qualified Graphics.Canvas as Canvas

import Graphics.Drawing.Color

-- | A `Point` consists of `x` and `y` coordinates.
type Point = { x :: Number, y :: Number }

-- | A single shape.
data Shape
  -- | A path is a list of points joined by line segments 
  = Path Boolean (List Point)
  -- | A rectangle consisting of the numbers left, top, width and height 
  | Rectangle { x :: Number, y :: Number, w :: Number, h :: Number }
  -- | A circle consisting of the numbers center-x, center-y and radius
  | Circle { x :: Number, y :: Number, r :: Number }

-- | Create a path.
path :: forall f. (Foldable f) => f Point -> Shape
path = Path false <<< toList

-- | Create a _closed_ path.
closed :: forall f. (Foldable f) => f Point -> Shape
closed = Path true <<< toList

-- | Create a rectangle from the left, top, width and height parameters.
rectangle :: Number -> Number -> Number -> Number -> Shape
rectangle x y w h = Rectangle { x: x, y: y, w: w, h: h }

-- | Create a circle from the left, top and radius parameters.
circle :: Number -> Number -> Number -> Shape
circle x y r = Circle { x: x, y: y, r: r }

-- | Encapsulates fill color etc.
newtype FillStyle = FillStyle 
  { color :: Maybe Color
  }

instance semigroupFillStyle :: Semigroup FillStyle where
  append (FillStyle f1) (FillStyle f2) = FillStyle { color: f1.color <|> f2.color }

instance monoidFillStyle :: Monoid FillStyle where
  mempty = FillStyle { color: Nothing }
  
-- | Set the fill color.
fillColor :: Color -> FillStyle
fillColor c = FillStyle { color: Just c }
  
-- | Encapsulates outline color etc.
newtype OutlineStyle = OutlineStyle 
  { color :: Maybe Color
  , lineWidth :: Maybe Number
  }
  
-- | Set the outline color.
outlineColor :: Color -> OutlineStyle
outlineColor c = OutlineStyle { color: Just c, lineWidth: Nothing }
  
-- | Set the line width.
lineWidth :: Number -> OutlineStyle
lineWidth c = OutlineStyle { color: Nothing, lineWidth: Just c }

instance semigroupOutlineStyle :: Semigroup OutlineStyle where
  append (OutlineStyle f1) (OutlineStyle f2) = OutlineStyle { color:     f1.color     <|> f2.color
                                                            , lineWidth: f1.lineWidth <|> f2.lineWidth 
                                                            }

instance monoidOutlineStyle :: Monoid OutlineStyle where
  mempty = OutlineStyle { color: Nothing
                        , lineWidth: Nothing
                        }

-- | A vector `Drawing`.
data Drawing 
  = Fill Shape FillStyle
  | Outline Shape OutlineStyle
  | Many (List Drawing)
  | Scale { scaleX :: Number, scaleY :: Number } Drawing
  | Translate { translateX :: Number, translateY :: Number } Drawing
  | Rotate Number Drawing
  | Clipped Shape Drawing

-- | Fill a `Shape`.
filled :: FillStyle -> Shape -> Drawing
filled = flip Fill

-- | Draw the outline of a `Shape`.
outlined :: OutlineStyle -> Shape -> Drawing
outlined = flip Outline

-- | Clip a `Drawing` to a `Shape`.
clipped :: Shape -> Drawing -> Drawing
clipped = Clipped

-- | Apply a scale transformation by providing the x and y scale factors.
scale :: Number -> Number -> Drawing -> Drawing
scale sx sy = Scale { scaleX: sx, scaleY: sy }

-- | Apply a translation by providing the x and y distances.
translate :: Number -> Number -> Drawing -> Drawing
translate tx ty = Translate { translateX: tx, translateY: ty }

-- | Apply a rotation by providing the angle.
rotate :: Number -> Drawing -> Drawing
rotate = Rotate

instance semigroupDrawing :: Semigroup Drawing where
  append (Many ds) d = Many (ds ++ singleton d)
  append d (Many ds) = Many (d : ds)
  append d1 d2 = Many (Cons d1 (Cons d2 Nil))

instance monoidDrawing :: Monoid Drawing where
  mempty = Many mempty

-- | Modify a `Drawing` by applying a transformation to every subdrawing.
everywhere :: (Drawing -> Drawing) -> Drawing -> Drawing
everywhere f = go
  where
  go (Many ds) = f (Many (map go ds))
  go (Scale s d) = f (Scale s (go d))
  go (Translate t d) = f (Translate t (go d))
  go (Rotate r d) = f (Rotate r (go d))
  go (Clipped s d) = f (Clipped s (go d))
  go other = f other
    
-- | Render a `Drawing` to a canvas.  
render :: forall eff. Canvas.Context2D -> Drawing -> Eff (canvas :: Canvas.Canvas | eff) Unit
render ctx = go
  where
  go (Fill sh style) = void $ Canvas.withContext ctx do
    applyFillStyle style
    Canvas.fillPath ctx $ 
      renderShape sh
  go (Outline sh style) = void $ Canvas.withContext ctx do
    applyOutlineStyle style
    Canvas.strokePath ctx $ 
      renderShape sh
  go (Many ds) = for_ ds go
  go (Scale s d) = void $ Canvas.withContext ctx do 
    Canvas.scale s ctx
    go d
  go (Translate t d) = void $ Canvas.withContext ctx do 
    Canvas.translate t ctx
    go d
  go (Rotate r d) = void $ Canvas.withContext ctx do 
    Canvas.rotate r ctx
    go d
  go (Clipped sh d) = void $ Canvas.withContext ctx do 
    renderShape sh
    Canvas.clip ctx
    go d
    
  applyFillStyle :: FillStyle -> Eff (canvas :: Canvas.Canvas | eff) Unit
  applyFillStyle (FillStyle fs) = do
    for_ fs.color $ \color -> Canvas.setFillStyle (colorString color) ctx
    
  applyOutlineStyle :: OutlineStyle -> Eff (canvas :: Canvas.Canvas | eff) Unit
  applyOutlineStyle (OutlineStyle fs) = do
    for_ fs.color $ \color -> Canvas.setStrokeStyle (colorString color) ctx
    for_ fs.lineWidth $ \width -> Canvas.setLineWidth width ctx
  
  renderShape :: Shape -> Eff (canvas :: Canvas.Canvas | eff) Unit
  renderShape = go
    where
    go (Path cl (Cons p rest)) = do
      Canvas.moveTo ctx p.x p.y
      for_ rest \p -> Canvas.lineTo ctx p.x p.y
      when cl $ void $ Canvas.closePath ctx
    go (Rectangle r) = void $ Canvas.rect ctx r
    go (Circle c) = void $ Canvas.arc ctx { x: c.x, y: c.y, r: c.r, start: 0.0, end: Math.pi * 2.0 }