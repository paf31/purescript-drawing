## Module Graphics.Drawing.Font

This module defines preset fonts, and functions for creating fonts.

#### `Font`

``` purescript
data Font
```

Fonts.

#### `font`

``` purescript
font :: FontFamily -> Int -> FontOptions -> Font
```

Create a `Font`.

#### `fontString`

``` purescript
fontString :: Font -> String
```

Turn a `Font` into a `String` which can be used with `Graphics.Canvas.setFont`.

#### `FontFamily`

``` purescript
newtype FontFamily
```

Font family.

#### `serif`

``` purescript
serif :: FontFamily
```

Serif font

#### `sansSerif`

``` purescript
sansSerif :: FontFamily
```

Sans serif font

#### `monospace`

``` purescript
monospace :: FontFamily
```

Monospaced font

#### `cursive`

``` purescript
cursive :: FontFamily
```

Cursive font

#### `fantasy`

``` purescript
fantasy :: FontFamily
```

Fantasy font

#### `customFont`

``` purescript
customFont :: String -> FontFamily
```

Use a custom font

#### `FontOptions`

``` purescript
newtype FontOptions
```

Encapsulates font options.

##### Instances
``` purescript
instance semigroupFontOptions :: Semigroup FontOptions
instance monoidFontOptions :: Monoid FontOptions
```

#### `bold`

``` purescript
bold :: FontOptions
```

Use a bold font.

#### `bolder`

``` purescript
bolder :: FontOptions
```

Use a bolder font.

#### `light`

``` purescript
light :: FontOptions
```

Use a light font.

#### `italic`

``` purescript
italic :: FontOptions
```

Use an italic style.

#### `oblique`

``` purescript
oblique :: FontOptions
```

Use an oblique style.

#### `smallCaps`

``` purescript
smallCaps :: FontOptions
```

Use small caps.


