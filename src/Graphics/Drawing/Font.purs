-- | This module defines preset fonts, and functions for creating fonts.

module Graphics.Drawing.Font
  ( Font, font, fontString
  , FontFamily, serif, sansSerif, monospace, cursive, fantasy, customFont
  , FontOptions, bold, bolder, light, italic, oblique, smallCaps
  ) where

import Prelude

import Control.Alt ((<|>))
import Data.Foldable (fold, intercalate)
import Data.Maybe (Maybe(..))

-- | Fonts.
data Font = Font FontFamily Int FontOptions

derive instance eqFont :: Eq Font

-- | Create a `Font`.
font :: FontFamily -> Int -> FontOptions -> Font
font = Font

-- | Turn a `Font` into a `String` which can be used with `Graphics.Canvas.setFont`.
fontString :: Font -> String
fontString (Font (FontFamily family) px opts) = optionsString opts <> " " <> show px <> "px " <> family

-- | Font family.
newtype FontFamily = FontFamily String

derive instance eqFontFamily :: Eq FontFamily

-- | Serif font
serif :: FontFamily
serif = FontFamily "serif"

-- | Sans serif font
sansSerif :: FontFamily
sansSerif = FontFamily "sans-serif"

-- | Monospaced font
monospace :: FontFamily
monospace = FontFamily "monospace"

-- | Cursive font
cursive :: FontFamily
cursive = FontFamily "cursive"

-- | Fantasy font
fantasy :: FontFamily
fantasy = FontFamily "fantasy"

-- | Use a custom font
customFont :: String -> FontFamily
customFont = FontFamily

-- | Encapsulates font options.
newtype FontOptions = FontOptions
  { style    :: Maybe String
  , variant  :: Maybe String
  , weight   :: Maybe String
  }

instance eqFontOptions :: Eq FontOptions where
  eq (FontOptions a) (FontOptions a') = a.style == a'.style
                                     && a.variant == a'.variant
                                     && a.weight == a'.weight

optionsString :: FontOptions -> String
optionsString (FontOptions opts) = intercalate " "
  [ fold opts.style
  , fold opts.variant
  , fold opts.weight
  ]

-- | Use a bold font.
bold :: FontOptions
bold = FontOptions { style: Nothing, variant: Nothing, weight: Just "bold" }

-- | Use a bolder font.
bolder :: FontOptions
bolder = FontOptions { style: Nothing, variant: Nothing, weight: Just "bolder" }

-- | Use a light font.
light :: FontOptions
light = FontOptions { style: Nothing, variant: Nothing, weight: Just "lighter" }

-- | Use an italic style.
italic :: FontOptions
italic = FontOptions { style: Just "italic", variant: Nothing, weight: Nothing }

-- | Use an oblique style.
oblique :: FontOptions
oblique = FontOptions { style: Just "oblique", variant: Nothing, weight: Nothing }

-- | Use small caps.
smallCaps :: FontOptions
smallCaps = FontOptions { style: Nothing, variant: Just "small-caps", weight: Nothing }

instance semigroupFontOptions :: Semigroup FontOptions where
  append (FontOptions fo1) (FontOptions fo2) =
    FontOptions { style:     fo1.style   <|> fo2.style
                , variant:   fo1.variant <|> fo2.variant
                , weight:    fo1.weight  <|> fo2.weight
                }

instance monoidFontOptions :: Monoid FontOptions where
  mempty = FontOptions { style: Nothing
                       , variant: Nothing
                       , weight: Nothing
                       }
