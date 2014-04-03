module Main where

import Data.Array
import Data.Tuple
import Data.Traversable
import Data.Monoid
import Data.Generics

import Control.Monad.Eff

import Graphics.Canvas
import Graphics.Canvas.Drawing

bounds :: Rectangle
bounds =
  { x: 0
  , y: 0
  , w: 400
  , h: 400
  }

foreign import getElementById
  "function getElementById(id) {\
  \  return function() {\
  \    return document.getElementById(id);\
  \  };\
  \}" :: forall eff. String -> Eff eff CanvasElement

circle :: Drawing
circle = Arc { cx: 0.5
             , cy: 0.5
             , r: 0.5
             , start: 0
             , end: Math.pi * 2 
             }

square :: Drawing
square = Rectangle { x: 0, y: 0, w: 1, h: 1 }

circles :: Number -> Drawing
circles n = 
  Composite $ flip map (range 0 (n - 1)) $ \i -> do  
    let
      theta = i / n * Math.pi * 2
      rect = { x: 0.5 + 0.25 * Math.sin theta - 0.1
             , y: 0.5 + 0.25 * Math.cos theta - 0.1
             , w: 0.2
             , h: 0.2
             }
    Scaled rect circle

carpet :: Drawing
carpet = squaresToCircles <<< go <<< go <<< go <<< go <<< go $ square
  where
  go :: Drawing -> Drawing
  go = everywhere (mkT quarter)

  quarter :: Drawing -> Drawing
  quarter (Rectangle r) = 
    let x' = r.x + r.w * 0.6
        y' = r.y + r.h * 0.6
        w' = r.w * 0.4
        h' = r.h * 0.4
    in Rectangle { x: r.x, y: y' , w: w', h: h' } <>
       Rectangle { x: x' , y: y' , w: w', h: h' } <>
       Rectangle { x: x' , y: r.y, w: w', h: h' }
  quarter other = other

  squaresToCircles :: Drawing -> Drawing
  squaresToCircles = everywhere (mkT toCircle)
  
  toCircle :: Drawing -> Drawing
  toCircle (Rectangle r) = Scaled r circle
  toCircle other = other

sineWave :: Drawing
sineWave = Path $ do
  x <- 0 `range` 100
  let y = Math.sin $ x / 100.0 * Math.pi * 4
  return (Tuple (x / 100.0) (y / 4 + 0.5))

main = do
  canvas <- getElementById "canvas"
  ctx <- getContext2D canvas

  setStrokeStyle "#000000" ctx
  setLineWidth 0.02 ctx

  let drawing = carpet 
  
  Debug.Trace.print drawing

  renderIn bounds ctx drawing
  
