module View.MrRow exposing (mrRow)

import Html exposing (Html, div, br, text, h3, span)
import Html.Attributes exposing(class)
import Model.Model exposing (MergeRequest, Msg)
import String exposing (fromInt)


boolToView: Bool -> Html msg
boolToView boolean = 
    if boolean then span [class "text-success"] [text "Yes"] else span [class "text-danger"] [text "No"]
            

approvals: Int -> Html msg
approvals numberOfApprovals = 
    if numberOfApprovals < 2 
    then span [class "text-danger"] [text (fromInt numberOfApprovals)] 
    else span [class "text-success"] [text (fromInt numberOfApprovals)]
            

pipelineStatusToView: Model.Model.PipelineStatus -> Html msg
pipelineStatusToView pipeline = 
    case pipeline of
        Model.Model.Passed -> span [class "text-success"] [text "Passed"]
        Model.Model.Warning -> span [class "text-warning"] [text "Warning"]
        Model.Model.Failed -> span [class "text-danger"] [text "Failed"]
    
withLabel: String -> Html Msg -> Html Msg
withLabel label component =
    div [] [
        span [class "font-weight-bold"] [text (label ++ ": ")]
        , component
    ]    


valueWithLabel: String -> String -> Html Msg
valueWithLabel label value =
    div [] [
        span [class "font-weight-bold"] [text (label ++ ": ")]
        , text value
    ]    

mrRow : MergeRequest -> Html Msg
mrRow mr =
    div [class "card m-2 p-3"] [ 
         div [ class "font-weight-bold"] [h3 [] [text mr.name]]  
        , div [] [valueWithLabel "Author" mr.author]  
        , div [] [withLabel "Approvals" (approvals mr.approvals)]  
        , div [] [withLabel "Pipeline status" (pipelineStatusToView mr.pipelinePassed)]  
        , div [] [valueWithLabel "Changed files" (fromInt mr.changedFiles)]  
    ]
