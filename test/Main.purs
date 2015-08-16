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
    outlined (rectangle 20.0 20.0 50.0 50.0) defaultStyle
    filled (circle 100.0 100.0 50.0) defaultStyle
