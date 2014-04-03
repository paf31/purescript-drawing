module Graphics.Canvas.Drawing where

import Data.Tuple
import Data.Traversable

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

renderIn :: forall eff. Rectangle -> Context2D -> Drawing -> Eff (canvas :: Canvas | eff) Context2D
renderIn box ctx drawing = withContext ctx $ do
  let factor = Math.min box.w box.h
  scale { scaleX: factor, scaleY: factor } ctx

  let offsetX = if box.w > box.h then box.x else box.x + (box.h - box.w) / 2
  let offsetY = if box.h > box.w then box.y else box.y + (box.w - box.h) / 2
  translate { translateX: offsetX, translateY: offsetY } ctx
  
  go drawing

  where
  go (Path (Tuple x0 y0 : rest)) = strokePath ctx $ do
    moveTo ctx x0 y0
    for rest $ \(Tuple x y) ->
      lineTo ctx x y
    return ctx
  go (Rectangle rect) = strokeRect ctx rect
  go (Arc a) = strokePath ctx $ arc ctx a
  go (Composite ds) = do
    traverse go ds
    return ctx
  go (Scaled box d) = renderIn box ctx d
