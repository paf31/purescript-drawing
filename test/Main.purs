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
    [ shadow (shadowColor black <> shadowBlur 10.0) $
        outlined (outlineColor red <> lineWidth 5.0) $ 
          rectangle 10.0 10.0 90.0 90.0
    , translate 120.0 0.0 $ 
        clipped (rectangle 0.0 0.0 50.0 50.0 <> rectangle 50.0 50.0 50.0 50.0) $ 
          filled (fillColor (lighten 0.5 red)) $ 
            circle 50.0 50.0 50.0
    , translate 240.0 0.0 $ 
        shadow (shadowColor black <> shadowBlur 10.0) $
          outlined (outlineColor (darken 0.5 red) <> lineWidth 3.0) $ 
            closed [ { x: 50.0,  y: 10.0 }
                   , { x: 0.0,   y: 100.0 }
                   , { x: 100.0, y: 100.0 }
                   ]
    ]