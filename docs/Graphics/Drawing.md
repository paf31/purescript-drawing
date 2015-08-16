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

#### `path`

``` purescript
path :: forall f. (Foldable f) => f Point -> Shape
```

Create a path.

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

#### `Style`

``` purescript
data Style
```

Encapsulates colors etc.

#### `defaultStyle`

``` purescript
defaultStyle :: Style
```

The default style

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
filled :: Shape -> Style -> Drawing
```

Fill a `Shape`.

#### `outlined`

``` purescript
outlined :: Shape -> Style -> Drawing
```

Draw the outline of a `Shape`.

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


