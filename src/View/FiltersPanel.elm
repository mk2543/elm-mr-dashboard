module View.FiltersPanel exposing (filtersPanel)

import Html exposing (..)
import Html.Attributes exposing (style, type_, checked)
import Html.Events exposing (onClick)
import Model.Model exposing (..)

checkbox : msg -> String -> Bool -> Html msg
checkbox msg name isChecked =
    label
        [ style "padding" "20px" ]
        [ input [ type_ "checkbox", onClick msg, checked isChecked ] []
        , text name
        ]
    

filtersPanel : Filters -> Html Msg
filtersPanel filters =
    fieldset [] [ 
         checkbox ToggleApprovedMrs " Approved MRs" filters.approvedMrsVisible 
        , checkbox ToggleFailedPipelines " Failed pipelines" filters.failedPipelinesVisible
        , checkbox ToggleWips " WIPs" filters.wipsVisible
    ]
