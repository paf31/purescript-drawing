module Test.Main where

import Prelude

import Data.Maybe
import Data.Foldable (fold)

import Control.Monad.Eff

import Graphics.Drawing
import Graphics.Canvas (getCanvasElementById, getContext2D)

main = do
  Just canvas <- getCanvasElementById "canvas"
  ctx <- getContext2D canvas

  render ctx $ fold
    [ outlined (outlineColor red <> lineWidth 5.0) $ 
        rectangle 20.0 20.0 50.0 50.0
    , clipped (rectangle 20.0 20.0 80.0 80.0) $ 
        filled (fillColor lightGreen) $ 
          circle 100.0 100.0 50.0
    , outlined (outlineColor blue <> lineWidth 3.0) $ 
        closed [ { x: 90.0,  y: 80.0 }
               , { x: 120.0, y: 120.0 }
               , { x: 60.0,  y: 120.0 }
               ]
    ]