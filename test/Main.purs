module Test.Main where

import Prelude

import Data.Int (toNumber)
import Data.Maybe (fromJust)
import Data.Array ((..))
import Data.Foldable (fold)

import Effect (Effect)

import Graphics.Drawing (scale, translate, shadowBlur, black, shadowColor,
                         shadow, render, rotate, closed, fillColor, filled)
import Graphics.Canvas (getCanvasElementById, getContext2D)
import Partial.Unsafe (unsafePartial)

import Math (sin, cos, pi)

import Color.Scale (sample)
import Color.Scale.Perceptual (magma)

main :: Effect Unit
main = do
  mcanvas <- getCanvasElementById "canvas"
  let canvas = unsafePartial (fromJust mcanvas)
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
    in filled (fillColor (sample magma (1.0 - toNumber (n - 1) / 5.0))) (closed pentagon)
       <> fold do i <- 0..4
                  pure (rotate (pi / 2.5 * (toNumber i + 0.5)) (translate 0.0 (cos (pi / 5.0) * (1.0 + s)) dr))

  pentagon = do
    i <- 0..5
    let theta = pi / 2.5 * toNumber i
    pure { x: sin theta, y: cos theta }
