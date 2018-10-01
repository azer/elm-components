module Main exposing (..)

import Form.Textbox as Textbox
import Form.Button as Button
import Form.Buttons as Buttons
import Styles exposing (..)
import Styles.Length exposing (..)
import Html.Styled as Styled
import Html


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type Msg
    = OnInputName String
    | OnInputEmail String
    | OnInputPassword String
    | OnInputPasswordRepeat String
    | OnInputBio String


init =
    let
        model =
            { name = Textbox.init ""
            , email = Textbox.init ""
            , password = Textbox.init ""
            , passwordRepeat = Textbox.init ""
            , bio = Textbox.init ""
            }
    in
        ( model, Cmd.none )


type alias Model =
    { name : Textbox.State
    , email : Textbox.State
    , password : Textbox.State
    , passwordAgain : Textbox.State
    , bio : Textbox.State
    }


update msg model =
    case Debug.log "[msg]" msg of
        OnInputName value ->
            let
                old =
                    model.name

                new =
                    { old | value = value }
            in
                ( { model | name = new }, Cmd.none )

        OnInputEmail value ->
            let
                old =
                    model.email

                new =
                    { old | value = value }
            in
                ( { model | email = new }, Cmd.none )

        OnInputPassword value ->
            let
                old =
                    model.password

                new =
                    { old | value = value }
            in
                ( { model | password = new }, Cmd.none )

        OnInputPasswordRepeat value ->
            let
                old =
                    model.passwordRepeat

                new =
                    { old | value = value }
            in
                ( { model | passwordRepeat = new }, Cmd.none )

        OnInputBio value ->
            let
                old =
                    model.bio

                new =
                    { old | value = value }
            in
                ( { model | bio = new }, Cmd.none )


view model =
    let
        textbox =
            Textbox.default

        button =
            Button.default

        buttons =
            Buttons.default
    in
        Styled.div
            [ []
                |> stretch
                |> center
                |> toCSS
            ]
            [ Styled.fieldset
                [ []
                    |> box { defaultBox | width = em 40 }
                    |> gap { defaultGap | inner = em 3 }
                    |> toCSS
                ]
                [ Textbox.view { textbox | label = "Your name", placeholder = "Faruk", onInput = OnInputName } model.name
                , Textbox.view { textbox | label = "Your e-mail address", placeholder = "faruk@eczacibasi.com", onInput = OnInputEmail } model.email
                , Textbox.view { textbox | label = "Password", onInput = OnInputPassword, password = True } model.password
                , Textbox.view { textbox | label = "Password (repeat)", onInput = OnInputPasswordRepeat, password = True } model.passwordRepeat
                , Textbox.view { textbox | label = "Bio", onInput = OnInputBio, multiline = True, placeholder = "Tell us about yourself", verticalResize = True } model.bio
                , Buttons.view buttons
                    [ Button.view { button | text = "Cancel" }
                    , Button.view { button | text = "Login", outlined = True }
                    , Button.view { button | text = "Sign Up", contained = True }
                    ]
                ]
            ]
            |> Styled.toUnstyled
