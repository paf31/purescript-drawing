module Graphics.Canvas.Drawing where

import Data.Maybe
import Data.Tuple
import Data.Array
import Data.Traversable
import Data.Monoid
import Data.Generics

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

instance monoidDrawing :: Monoid Drawing where
  mempty = Composite []
  (<>) (Composite ds) d = Composite (ds <> [d])
  (<>) d (Composite ds) = Composite (d : ds)
  (<>) d1 d2 = Composite [d1, d2]

rectTerm :: Rectangle -> Tm
rectTerm r = 
  TmObj [ { key: "x", value: term r.x }
        , { key: "y", value: term r.y }
        , { key: "w", value: term r.w }
        , { key: "h", value: term r.h }
        ]

rectUnTerm :: Tm -> Maybe Rectangle
rectUnTerm (TmObj [ { key = "x", value = x }
                  , { key = "y", value = y }
                  , { key = "w", value = w }
                  , { key = "h", value = h }
                  ]) = mkRect <$> unTerm x <*> unTerm y <*> unTerm w <*> unTerm h
  where
  mkRect x y w h = { x: x, y: y, w: w, h: h }

instance genericDrawing :: Generic Drawing where
  typeOf _ = TyCon { tyCon: "Graphics.Canvas.Drawing.Drawing", args: [] }

  term (Path p)        = TmCon { con: "Graphics.Canvas.Drawing.Path",         values: [term p] } 
  term (Rectangle r)   = TmCon { con: "Graphics.Canvas.Drawing.Rectangle",    values: [rectTerm r] } 
  term (Arc a)         = TmCon { con: "Graphics.Canvas.Drawing.Arc",          values: [
    TmObj [ { key: "cx", value: term a.cx } 
          , { key: "cy", value: term a.cy }
          , { key: "r", value: term a.r }
          , { key: "start", value: term a.start }
          , { key: "end", value: term a.end }
          ]
    ] } 
  term (Composite ds)  = TmCon { con: "Graphics.Canvas.Drawing.Composite",    values: [term ds] } 
  term (Scaled r d)    = TmCon { con: "Graphics.Canvas.Drawing.Scaled",       values: [rectTerm r, term d] } 

  unTerm (TmCon { con = "Graphics.Canvas.Drawing.Path",         values = [p] }) = Path <$> unTerm p
  unTerm (TmCon { con = "Graphics.Canvas.Drawing.Rectangle",    values = [r] }) = Rectangle <$> rectUnTerm r
    where
    mkRect x y w h = { x: x, y: y, w: w, h: h }
  unTerm (TmCon { con = "Graphics.Canvas.Drawing.Arc",          values = [
    TmObj [ { key = "cx",    value = cx }
          , { key = "cy",    value = cy }
          , { key = "r",     value = r }
          , { key = "start", value = start }
          , { key = "end",   value = end }
          ]
    ] }) = Arc <$> (mkArc <$> unTerm cx <*> unTerm cy <*> unTerm r <*> unTerm start <*> unTerm end)
    where
    mkArc cx cy r start end = { cx: cx, cy: cy, r: r, start: start, end: end }
  unTerm (TmCon { con = "Graphics.Canvas.Drawing.Composite",    values = [ds] }) = Composite <$> unTerm ds
  unTerm (TmCon { con = "Graphics.Canvas.Drawing.Scaled",       values = [r, d] }) = Scaled <$> rectUnTerm r <*> unTerm d
  unTerm _ = Nothing

instance showDrawing :: Show Drawing where
  show = gshow

renderIn :: forall eff. Rectangle -> Context2D -> Drawing -> Eff (canvas :: Canvas | eff) Context2D
renderIn box ctx drawing = withContext ctx $ do
  let offsetX = if box.w > box.h then box.x else box.x + (box.h - box.w) / 2
  let offsetY = if box.h > box.w then box.y else box.y + (box.w - box.h) / 2
  translate { translateX: offsetX, translateY: offsetY } ctx
  
  let factor = Math.min box.w box.h
  scale { scaleX: factor, scaleY: factor } ctx

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
