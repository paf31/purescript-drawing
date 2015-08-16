module Test.Main where

import Prelude

import Data.Maybe

import Control.Monad.Eff

import Graphics.Drawing
import Graphics.Canvas (getCanvasElementById, getContext2D)

main = do
  Just canvas <- getCanvasElementById "canvas"
  ctx <- getContext2D canvas

  let bind x f = x <> f unit

  render ctx do
    outlined (outlineColor red <> lineWidth 5.0) $ rectangle 20.0 20.0 50.0 50.0
    filled (fillColor lightGreen) $ circle 100.0 100.0 50.0
    outlined (outlineColor blue <> lineWidth 3.0) $ closed [ { x: 130.0, y: 120.0 }
                                                           , { x: 160.0, y: 160.0 }
                                                           , { x: 100.0, y: 160.0 }
                                                           ]
