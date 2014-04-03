module Main where

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

main = do
  canvas <- getElementById "canvas"
  ctx <- getContext2D canvas

  setStrokeStyle "#000000" ctx
  setLineWidth 0.01 ctx

  renderIn bounds ctx $ 
    Arc { cx: 0.5
        , cy: 0.5
        , r: 0.5
        , start: 0
        , end: Math.pi * 2 
        }
