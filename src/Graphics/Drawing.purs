-- | This module defines a type `Drawing` for creating vector graphics.

module Graphics.Drawing 
  ( Point()
  , Shape(), path, rectangle, circle
  , Style(), defaultStyle
  , Drawing(), filled, outlined, scale, translate, rotate
  , everywhere
  , render
  ) where
      
import Prelude

import Data.List
import Data.Monoid
import Data.Foldable (Foldable, for_)

import Control.Monad.Eff

import qualified Graphics.Canvas as Canvas

-- | A `Point` consists of `x` and `y` coordinates.
type Point = { x :: Number, y :: Number }

-- | A single shape.
data Shape
  -- | A path is a list of points joined by line segments 
  = Path (List Point)
  -- | A rectangle consisting of the numbers left, top, width and height 
  | Rectangle { x :: Number, y :: Number, w :: Number, h :: Number }
  -- | A circle consisting of the numbers center-x, center-y and radius
  | Circle { x :: Number, y :: Number, r :: Number }

-- | Create a path.
path :: forall f. (Foldable f) => f Point -> Shape
path = Path <<< toList

-- | Create a rectangle from the left, top, width and height parameters.
rectangle :: Number -> Number -> Number -> Number -> Shape
rectangle x y w h = Rectangle { x: x, y: y, w: w, h: h }

-- | Create a circle from the left, top and radius parameters.
circle :: Number -> Number -> Number -> Shape
circle x y r = Circle { x: x, y: y, r: r }

-- | Encapsulates colors etc.
data Style = Style

-- | The default style
defaultStyle :: Style
defaultStyle = Style

-- | A vector `Drawing`.
data Drawing 
  = Fill Shape Style
  | Outline Shape Style
  | Many (List Drawing)
  | Scale { scaleX :: Number, scaleY :: Number } Drawing
  | Translate { translateX :: Number, translateY :: Number } Drawing
  | Rotate Number Drawing

-- | Fill a `Shape`.
filled :: Shape -> Style -> Drawing
filled = Fill

-- | Draw the outline of a `Shape`.
outlined :: Shape -> Style -> Drawing
outlined = Outline

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
  go other = f other
    
-- | Render a `Drawing` to a canvas.  
render :: forall eff. Canvas.Context2D -> Drawing -> Eff (canvas :: Canvas.Canvas | eff) Unit
render ctx = go
  where
  go (Fill sh style) = void $ Canvas.withContext ctx do
    --setFillStyle ctx style
    Canvas.fillPath ctx $ 
      renderShape ctx sh
  go (Outline sh style) = void $ Canvas.withContext ctx do
    --setStrokeStyle ctx style
    Canvas.strokePath ctx $ 
      renderShape ctx sh
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
  
renderShape :: forall eff. Canvas.Context2D -> Shape -> Eff (canvas :: Canvas.Canvas | eff) Unit
renderShape ctx = go
  where
  go (Path (Cons p rest)) = do
    Canvas.moveTo ctx p.x p.y
    for_ rest \p -> Canvas.lineTo ctx p.x p.y
  go (Rectangle r) = void $ Canvas.rect ctx r
  go (Circle c) = void $ Canvas.arc ctx { x: c.x, y: c.y, r: c.r, start: 0.0, end: Math.pi * 2.0 }