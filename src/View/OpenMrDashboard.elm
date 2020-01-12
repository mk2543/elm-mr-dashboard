module View.OpenMrDashboard exposing(dashboard)

import View.MrRow exposing (mrRow)
import Html exposing (Html, div, text)
import Model.Model exposing (Model, Msg)
import List exposing (map)

dashboard : Model -> Html Msg
dashboard model =
    div [] (map mrRow model.mergeRequests) 

