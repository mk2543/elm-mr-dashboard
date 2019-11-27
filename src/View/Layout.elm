module View.Layout exposing (view)

import Model.Model exposing(Model, Msg)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Browser
import Html exposing (Html, div, h1, img, text)


view: Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet -- creates an inline style node with the Bootstrap CSS
        , Grid.row []
            [ Grid.col []
                [ h1 [] [ text "Some content for my view here..." ]
                , div [] [ text "bla bla bla" ]
                ]
            ]
        ]