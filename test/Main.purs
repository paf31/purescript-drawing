module Test.Main where

import Prelude

import Data.Int
import Data.Maybe
import Data.Array ((..))
import Data.Monoid (mempty)
import Data.Foldable (fold)

import Control.Monad.Eff

import Graphics.Drawing
import Graphics.Canvas (getCanvasElementById, getContext2D)

main = do
  Just canvas <- getCanvasElementById "canvas"
  ctx <- getContext2D canvas

  render ctx $ 
    shadow (shadowColor black <> shadowBlur 10.0) $
      translate 400.0 400.0 $ 
        scale 200.0 200.0 $ 
          go 6
  where
  s = 0.375
      
  go 0 = mempty
  go n = 
    let dr = scale s s (go (n - 1))
    in filled (fillColor (lighten (1.0 - toNumber n / 6.0) black)) (closed pentagon) 
       <> fold do i <- 0..5
                  return (rotate (Math.pi / 2.5 * (toNumber i + 0.5)) (translate 0.0 (Math.cos (Math.pi / 5.0) * (1.0 + s)) dr))

  pentagon = do
    i <- 0..5
    let theta = Math.pi / 2.5 * toNumber i
    return { x: Math.sin theta, y: Math.cos theta }
