module Form.Textbox exposing (..)

import Styles exposing (..)
import Styles.Length exposing (..)
import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Events
import Dom
import Task
import Css exposing (hex, rgb)


type alias Config msg =
    { placeholder : String
    , label : String
    , icon : String
    , multiline : Bool
    , height : Length
    , password : Bool
    , resize : Bool
    , horizontalResize : Bool
    , verticalResize : Bool
    , onInput : String -> msg
    }


type alias State =
    { value : String
    , error : String
    , focused : Bool
    }

init value =
    { value = value
    , error = ""
    , focused = False
    }


default =
    { placeholder = ""
    , label = ""
    , icon = ""
    , multiline = False
    , height = em 6
    , password = False
    , resize = False
    , horizontalResize = False
    , verticalResize = False
    , onInput = \_ -> Cmd.none
    }


view config state =
    let
        id =
            config.label
    in
        (container config state)
            [ input config state
            , label config state
            ]


container config state =
    Html.div
        [ [ Css.border3 (Css.px 1) Css.solid (Css.hex "ccc")
          , Css.pseudoClass "focus-within" ([] |> shadow 0.15 )
          ]
            |> gap { defaultGap | outer = around [ em 2, auto ] }
            |> rounded (px 5)
            |> shadow 0.04
            |> relative defaultPosition
            |> toCSS
        ]


input config state =
    (tag config)
        ([ Attr.placeholder config.placeholder
        , Attr.value state.value
        , Events.onInput config.onInput
        , [ Css.pseudoElement "-webkit-input-placeholder" [ Css.color Css.transparent ]
          , Css.pseudoClass "focus::-webkit-input-placeholder" [ Css.color (Css.hex "#aaa") ]
          , Css.pseudoClass "focus + label" (labelStyle True)
          , Css.property "z-index" "1"
          , Css.property "resize" (resize config)
          ]
            |> box { defaultBox | width = pct 100, height = (if config.multiline then config.height else pct 100) }
            |> sans { defaultTypo | size = em 1, fg = hex "#222" }
            |> gap { defaultGap | inner = em 0.8 }
            |> transparentBg
            |> noborder
            |> nooutline
            |> toCSS
        ] ++ inputType config)
        (if config.multiline then [ Html.text state.value ] else [])


resize config =
    if config.resize then
        "both"
    else if config.horizontalResize then
        "horizontal"
    else if config.verticalResize then
        "vertical"
    else
        "none"

inputType config =
    if config.multiline then
        []
    else if config.password then
        [ Attr.type_ "password" ]
    else
        [ Attr.type_ "text" ]


tag config =
    if config.multiline then
        Html.textarea
    else
        Html.input


label config state =
    Html.label
        [ (labelStyle (state.value /= ""))
            |> monospace { defaultTypo | size = em 0.8, uppercase = True }
            |> box { defaultBox | block = True }
            |> absolute defaultPosition
            |> easein 0.1
            |> toCSS
        ]
        [ Html.text (config.label) ]


labelStyle outside =
    if outside then
        [ Css.top (Css.px -18)
        , Css.left (Css.px 0)
        , Css.transform (Css.scale 0.95)
        , Css.property "transform-origin" "left"
        , Css.cursor Css.pointer
        , Css.color (hex "24b47e")
        ]
    else
        [ Css.top (Css.px 15)
        , Css.left (Css.px 13)
        , Css.cursor Css.text_
        , Css.color (hex "888")
        , Css.property "z-index" "-1"
        ]
