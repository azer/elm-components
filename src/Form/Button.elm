module Form.Button exposing (..)

import Html.Styled as Html
import Styles exposing (..)
import Styles.Length exposing (..)
import Css exposing (hex, rgb)


type alias Config msg =
    { outlined : Bool
    , contained : Bool
    , disabled : Bool
    , text : String
    , onClick : msg
    }


default =
    { outlined = False
    , contained = False
    , disabled = False
    , text = "Button"
    , onClick = \_ -> Cmd.none
    }


view config =
    if config.contained then
        contained config
    else if config.outlined then
        outlined config
    else
        plain config

contained config =
    Html.button
        [ [ Css.cursor Css.pointer]
            |> box { defaultBox | bg = hex "#fff", bg = hex "#00b473" }
            |> sans { defaultTypo | size = em 0.85, weight = 600, fg = hex "#fff", uppercase = True, letterSpacing = em 0.05 }
            |> gap { defaultGap | inner = around [ px 13, px 25 ] }
            |> shadow 0.09
            |> nooutline
            |> noborder
            |> toCSS
        ]
        [ Html.text config.text ]

outlined config =
    Html.button
        [ [ Css.cursor Css.pointer
          , Css.border3 (Css.px 1) Css.solid (Css.hex "ccc")
          ]
            |> box { defaultBox | bg = hex "#fff", fg = hex "#333" }
            |> sans { defaultTypo | size = em 0.95, weight = 600, fg = hex "#333", letterSpacing = em 0.05 }
            |> gap { defaultGap | inner = around [ px 10, px 15 ] }
            |> shadow 0.09
            |> nooutline
            |> toCSS
        ]
        [ Html.text config.text ]

plain config =
    Html.button
        [ [ Css.cursor Css.pointer
          , Css.property "border" "0"
          ]
            |> box { defaultBox | bg = hex "#fff", fg = hex "#333" }
            |> sans { defaultTypo | size = em 0.95, weight = 600, fg = hex "#333", letterSpacing = em 0.05 }
            |> nooutline
            |> noborder
            |> toCSS
        ]
        [ Html.text config.text ]
