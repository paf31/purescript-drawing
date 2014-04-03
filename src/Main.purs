module Main where

import Data.Array
import Data.Tuple
import Data.Traversable

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

sineWave :: Drawing
sineWave = Path $ do
  x <- 0 `range` 100
  let y = Math.sin $ x / 100.0 * Math.pi * 4
  return (Tuple (x / 100.0) (y / 4 + 0.5))

main = do
  canvas <- getElementById "canvas"
  ctx <- getContext2D canvas

  setStrokeStyle "#000000" ctx
  setLineWidth 0.01 ctx

  renderIn bounds ctx $ circles 30
  
  -- renderIn bounds ctx sineWave 
