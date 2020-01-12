module View.MrRow exposing (mrRow)

import Html exposing (Html, div, text)
import Model.Model exposing (MergeRequest, Msg)


mrRow : MergeRequest -> Html Msg
mrRow mr =
    div [] [ 
        div [] [text ("ID: " ++ mr.id)]  
        , div [] [text ("NAME: " ++ mr.name)]  
    ]
