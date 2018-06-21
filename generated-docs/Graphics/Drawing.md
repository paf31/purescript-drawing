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
Eq Shape
Semigroup Shape
Monoid Shape
```

#### `path`

``` purescript
path :: forall f. Foldable f => f Point -> Shape
```

Create a path.

#### `closed`

``` purescript
closed :: forall f. Foldable f => f Point -> Shape
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

#### `arc`

``` purescript
arc :: Number -> Number -> Number -> Number -> Number -> Shape
```

Create a circular arc from the left, top, start angle, end angle and
radius parameters.

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

#### `shadowOffset`

``` purescript
shadowOffset :: Number -> Number -> Shadow
```

Set the shadow blur.

#### `shadowBlur`

``` purescript
shadowBlur :: Number -> Shadow
```

Set the shadow blur.

#### `shadowColor`

``` purescript
shadowColor :: Color -> Shadow
```

Set the shadow color.

#### `shadow`

``` purescript
shadow :: Shadow -> Drawing -> Drawing
```

Apply a `Shadow` to a `Drawing`.

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
render :: Context2D -> Drawing -> Effect Unit
```

Render a `Drawing` to a canvas.


### Re-exported from Color:

#### `Color`

``` purescript
data Color
```

The representation of a color.

Note:
- The `Eq` instance compares two `Color`s by comparing their (integer) RGB
  values. This is different from comparing the HSL values (for example,
  HSL has many different representations of black (arbitrary hue and
  saturation values).
- Colors outside the sRGB gamut which cannot be displayed on a typical
  computer screen can not be represented by `Color`.


##### Instances
``` purescript
Show Color
Eq Color
```

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

