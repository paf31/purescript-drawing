module Graphics.Canvas.Drawing where

import Data.Maybe
import Data.Tuple
import Data.Array
import Data.Traversable
import Data.Monoid

import Control.Monad.Eff

import Graphics.Canvas

data Drawing
  -- |
  -- A path is a list of line segments 
  --
  = Path [Tuple Number Number]
  -- |
  -- A rectangle consisting of the numbers left, top, width and height 
  --
  | Rectangle Rectangle
  -- |
  -- A circle consisting of the numbers center-x, center-y and radius
  --
  | Arc Arc
  -- |
  -- A drawing composed of several other drawings
  --
  | Composite [Drawing]
  -- |
  -- A drawing which has been scaled to be displayed inside a rectangle
  --
  | Scaled Rectangle Drawing

instance monoidDrawing :: Monoid Drawing where
  mempty = Composite []
  (<>) (Composite ds) d = Composite (ds <> [d])
  (<>) d (Composite ds) = Composite (d : ds)
  (<>) d1 d2 = Composite [d1, d2]

everywhere :: (Drawing -> Drawing) -> Drawing -> Drawing
everywhere f (Composite ds) = f (Composite (map (everywhere f) ds))
everywhere f (Scaled r d) = f (Scaled r (everywhere f d))
everywhere f other = f other

renderIn :: forall eff. Rectangle -> Context2D -> Drawing -> Eff (canvas :: Canvas | eff) Context2D
renderIn box ctx drawing = withContext ctx $ do
  let offsetX = if box.w > box.h then box.x else box.x + (box.h - box.w) / 2
  let offsetY = if box.h > box.w then box.y else box.y + (box.w - box.h) / 2
  translate { translateX: offsetX, translateY: offsetY } ctx
  
  let factor = Math.min box.w box.h
  scale { scaleX: factor, scaleY: factor } ctx

  go drawing

  where
  go (Path (Tuple x0 y0 : rest)) = fillPath ctx $ do
    moveTo ctx x0 y0
    for rest $ \(Tuple x y) ->
      lineTo ctx x y
    return ctx
  go (Rectangle rect) = fillRect ctx rect
  go (Arc a) = fillPath ctx $ arc ctx a
  go (Composite ds) = do
    traverse go ds
    return ctx
  go (Scaled box d) = renderIn box ctx d
