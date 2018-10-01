module Form.Buttons exposing (..)

import Html.Styled as Html
import Styles exposing (..)
import Styles.Length exposing (..)
import Styles.Align exposing (..)
import Css
import Css.Foreign


type alias Config =
    { left : Bool
    , right : Bool
    , center : Bool
    }


default =
    { left = False
    , right = True
    , center = False
    }


view config children =
    Html.div
        [ [ Css.Foreign.children [ Css.Foreign.everything [ Css.property "margin-right" "10px", Css.lastChild [ Css.property "margin-right" "0" ] ] ]
          ]
            |> box { defaultBox | width = auto }
            |> flex { defaultFlex | justifyContent = flexEnd }
            |> toCSS
        ]
        children
