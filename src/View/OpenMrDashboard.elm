module View.OpenMrDashboard exposing(dashboard)

import View.MrRow exposing (mrRow)
import View.FiltersPanel exposing (filtersPanel)
import Html exposing (Html, div)
import Html.Attributes exposing(class)
import Model.Model exposing (..)
import List exposing (map)
import String exposing(startsWith)

alwaysTrueFilter: MergeRequest -> Bool
alwaysTrueFilter _ = True

applyWipFilter: Filters -> MergeRequest -> Bool
applyWipFilter filters = 
    if filters.wipsVisible then alwaysTrueFilter else \mr ->  not (startsWith "WIP" mr.name)

applyApprovalsFilter: Filters -> MergeRequest -> Bool
applyApprovalsFilter filters = 
    if filters.approvedMrsVisible then alwaysTrueFilter else \mr -> mr.approvals < 2 

applyPipelineFilter: Filters -> MergeRequest -> Bool
applyPipelineFilter filters = 
    if filters.failedPipelinesVisible then alwaysTrueFilter else \mr -> not (mr.pipelinePassed == Failed) 

filterMrs : List MergeRequest -> Filters -> List MergeRequest
filterMrs allMrs filters = 
    let wipFilter = applyWipFilter filters
        approvalsFilter = applyApprovalsFilter filters
        pipelineFilter = applyPipelineFilter filters
    in    
        allMrs
        |> List.filter wipFilter 
        |> List.filter approvalsFilter
        |> List.filter pipelineFilter
       

dashboard : Model -> Html Msg
dashboard model =
    let filteredMrs = filterMrs model.mergeRequests model.filters
    in 
        div [] [
            filtersPanel model.filters
            , div [ class "d-flex flex-wrap"] (map mrRow filteredMrs) 
        ]

