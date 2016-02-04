## Module Graphics.Drawing

This module defines a type `Drawing` for creating vector graphics.

#### `Point`

``` purescript
type Point = { x :: Number, y :: Number }
```

A `Point` consists of `x` and `y` coordinates.

#### `Shape`

``` purescript
data Shape
```

A single shape.

##### Instances
``` purescript
Semigroup Shape
Monoid Shape
Eq Shape
```

#### `path`

``` purescript
path :: forall f. (Foldable f) => f Point -> Shape
```

Create a path.

#### `closed`

``` purescript
closed :: forall f. (Foldable f) => f Point -> Shape
```

Create a _closed_ path.

#### `rectangle`

``` purescript
rectangle :: Number -> Number -> Number -> Number -> Shape
```

Create a rectangle from the left, top, width and height parameters.

#### `circle`

``` purescript
circle :: Number -> Number -> Number -> Shape
```

Create a circle from the left, top and radius parameters.

#### `FillStyle`

``` purescript
newtype FillStyle
```

Encapsulates fill color etc.

##### Instances
``` purescript
Semigroup FillStyle
Monoid FillStyle
Eq FillStyle
```

#### `fillColor`

``` purescript
fillColor :: Color -> FillStyle
```

Set the fill color.

#### `OutlineStyle`

``` purescript
newtype OutlineStyle
```

Encapsulates outline color etc.

##### Instances
``` purescript
Semigroup OutlineStyle
Monoid OutlineStyle
Eq OutlineStyle
```

#### `outlineColor`

``` purescript
outlineColor :: Color -> OutlineStyle
```

Set the outline color.

#### `lineWidth`

``` purescript
lineWidth :: Number -> OutlineStyle
```

Set the line width.

#### `Shadow`

``` purescript
newtype Shadow
```

Encapsulates shadow settings etc.

##### Instances
``` purescript
Eq Shadow
Semigroup Shadow
Monoid Shadow
```

#### `shadowColor`

``` purescript
shadowColor :: Color -> Shadow
```

Set the shadow color.

#### `shadowBlur`

``` purescript
shadowBlur :: Number -> Shadow
```

Set the shadow blur.

#### `shadowOffset`

``` purescript
shadowOffset :: Number -> Number -> Shadow
```

Set the shadow blur.

#### `Drawing`

``` purescript
data Drawing
```

A vector `Drawing`.

##### Instances
``` purescript
Semigroup Drawing
Monoid Drawing
Eq Drawing
```

#### `filled`

``` purescript
filled :: FillStyle -> Shape -> Drawing
```

Fill a `Shape`.

#### `outlined`

``` purescript
outlined :: OutlineStyle -> Shape -> Drawing
```

Draw the outline of a `Shape`.

#### `clipped`

``` purescript
clipped :: Shape -> Drawing -> Drawing
```

Clip a `Drawing` to a `Shape`.

#### `shadow`

``` purescript
shadow :: Shadow -> Drawing -> Drawing
```

Apply a `Shadow` to a `Drawing`.

#### `scale`

``` purescript
scale :: Number -> Number -> Drawing -> Drawing
```

Apply a scale transformation by providing the x and y scale factors.

#### `translate`

``` purescript
translate :: Number -> Number -> Drawing -> Drawing
```

Apply a translation by providing the x and y distances.

#### `rotate`

``` purescript
rotate :: Number -> Drawing -> Drawing
```

Apply a rotation by providing the angle.

#### `text`

``` purescript
text :: Font -> Number -> Number -> FillStyle -> String -> Drawing
```

Render some text.

#### `everywhere`

``` purescript
everywhere :: (Drawing -> Drawing) -> Drawing -> Drawing
```

Modify a `Drawing` by applying a transformation to every subdrawing.

#### `render`

``` purescript
render :: forall eff. Context2D -> Drawing -> Eff (canvas :: Canvas | eff) Unit
```

Render a `Drawing` to a canvas.


### Re-exported from Color:

#### `Color`

``` purescript
data Color
```

The representation of a color.

##### Instances
``` purescript
Show Color
Eq Color
```

#### `black`

``` purescript
black :: Color
```

The color black.

#### `complementary`

``` purescript
complementary :: Color -> Color
```

Get the complementary color (hue rotated by 180°).

#### `cssStringHSLA`

``` purescript
cssStringHSLA :: Color -> String
```

The CSS representation of the color in the form `hsl(..)` or `hsla(...)`.

#### `darken`

``` purescript
darken :: Number -> Color -> Color
```

Darken a color by subtracting a certain amount (number between -1.0 and
1.0) from the lightness channel. If the number is negative, the color is
lightened.

#### `desaturate`

``` purescript
desaturate :: Number -> Color -> Color
```

Decrease the saturation of a color by subtracting a certain amount (number
between -1.0 and 1.0) from the saturation channel. If the number is
negative, the color is saturated.

#### `grayscale`

``` purescript
grayscale :: Number -> Color
```

Create a gray tone from a lightness values (0.0 is black, 1.0 is white).

#### `hsl`

``` purescript
hsl :: Number -> Number -> Number -> Color
```

Create a `Color` from hue, saturation, lightness and alpha values.

#### `hsla`

``` purescript
hsla :: Number -> Number -> Number -> Number -> Color
```

Create a `Color` from hue, saturation, lightness and alpha values.

#### `lighten`

``` purescript
lighten :: Number -> Color -> Color
```

Lighten a color by adding a certain amount (number between -1.0 and 1.0)
to the lightness channel. If the number is negative, the color is
darkened.

#### `rgb`

``` purescript
rgb :: Int -> Int -> Int -> Color
```

Create a `Color` from RGB values between 0 and 255.

#### `rgb'`

``` purescript
rgb' :: Number -> Number -> Number -> Color
```

Create a `Color` from RGB values between 0.0 and 1.0.

#### `rgba`

``` purescript
rgba :: Int -> Int -> Int -> Number -> Color
```

Create a `Color` from integer RGB values between 0 and 255 and a floating
point alpha value between 0.0 and 1.0.

#### `rgba'`

``` purescript
rgba' :: Number -> Number -> Number -> Number -> Color
```

Create a `Color` from RGB values between 0.0 and 1.0 and an alpha value
between 0.0 and 1.0.

#### `saturate`

``` purescript
saturate :: Number -> Color -> Color
```

Increase the saturation of a color by adding a certain amount (number
between -1.0 and 1.0) to the saturation channel. If the number is
negative, the color is desaturated.

#### `toHSLA`

``` purescript
toHSLA :: Color -> { h :: Number, s :: Number, l :: Number, a :: Number }
```

Convert a `Color` to its hue, saturation, lightness and alpha values.

#### `toRGBA`

``` purescript
toRGBA :: Color -> { r :: Int, g :: Int, b :: Int, a :: Number }
```

Convert a `Color` to its red, green, blue and alpha values.

#### `white`

``` purescript
white :: Color
```

The color white.

### Re-exported from Graphics.Drawing.Font:

#### `Font`

``` purescript
data Font
```

Fonts.

##### Instances
``` purescript
Eq Font
```

#### `fontString`

``` purescript
fontString :: Font -> String
```

Turn a `Font` into a `String` which can be used with `Graphics.Canvas.setFont`.

