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
instance semigroupShape :: Semigroup Shape
instance monoidShape :: Monoid Shape
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
instance semigroupFillStyle :: Semigroup FillStyle
instance monoidFillStyle :: Monoid FillStyle
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
instance semigroupOutlineStyle :: Semigroup OutlineStyle
instance monoidOutlineStyle :: Monoid OutlineStyle
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
instance semigroupShadow :: Semigroup Shadow
instance monoidShadow :: Monoid Shadow
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
instance semigroupDrawing :: Semigroup Drawing
instance monoidDrawing :: Monoid Drawing
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


