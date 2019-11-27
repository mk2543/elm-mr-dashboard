module Main exposing (..)

import Browser
import View.Layout exposing(view)
import Model.Model exposing(Model, Msg)



---- MODEL ----


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )

---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----




---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
