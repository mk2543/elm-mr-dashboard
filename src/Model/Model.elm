module Model.Model exposing(..)
import Http
import Json.Decode exposing (Decoder, succeed, fail, map8, field, string, int, andThen, list)


type alias Model =
    {
        gitlabUrl: String
        , mergeRequests: List MergeRequest
        , filters: Filters
    }

type PipelineStatus = Passed | Failed | Warning   
type App = Frontend | Backend 

type alias MrId = String

type alias MergeRequest = 
  {
    id: MrId
    , appType: App
    , name: String
    , author: String
    , openSince: String
    , approvals: Int
    , pipelinePassed: PipelineStatus
    , changedFiles: Int
  }

type alias Filters = {
    approvedMrsVisible: Bool
    , failedPipelinesVisible: Bool
    , wipsVisible: Bool
  }  

type Msg = ToggleApprovedMrs | ToggleFailedPipelines | ToggleWips | GetMergeRequests | MergeRequestsRetrieved (Result Http.Error (List MergeRequest))

updateToggles: Msg -> Filters -> Filters
updateToggles msg filters = 
    case msg of
        ToggleApprovedMrs -> { filters | approvedMrsVisible = not filters.approvedMrsVisible }
        ToggleFailedPipelines -> { filters | failedPipelinesVisible = not filters.failedPipelinesVisible }   
        ToggleWips -> { filters | wipsVisible = not filters.wipsVisible }
        _ -> filters


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of 
        GetMergeRequests -> ( model, getMergeRequests )
        _ -> ( { model | filters = updateToggles msg model.filters }, Cmd.none )

getMergeRequests: Cmd Msg
getMergeRequests =
    Http.get { url = "https://my-json-server.typicode.com/mk2543/elm-mr-dashboard/merge-requests"
    , expect= Http.expectJson MergeRequestsRetrieved mergeRequestsDecoder
    }


mergeRequestsDecoder: Decoder (List MergeRequest)
mergeRequestsDecoder = list singleMergeRequestDecoder

singleMergeRequestDecoder : Decoder MergeRequest
singleMergeRequestDecoder =
  map8 MergeRequest
        (field "id" string)
        (field "appType" string |> andThen appTypeDecoder)
        (field "name" string) 
        (field "author" string) 
        (field "openSince" string) 
        (field "approvals" int) 
        (field "pipelinePassed" string |> andThen pipelineStatusDecoder)
        (field "changedFiles" int) 
        
appTypeDecoder : String -> Decoder App
appTypeDecoder string =
    case string of
        "Frontend" -> succeed Frontend
        "Backend" -> succeed Backend
        _ -> fail <| "Invalid pipeline status: " ++ string

pipelineStatusDecoder : String -> Decoder PipelineStatus
pipelineStatusDecoder string =
    case string of
        "Passed" -> succeed Passed
        "Warning" -> succeed Warning
        "Failed" -> succeed Failed
        _ -> fail <| "Invalid pipeline status: " ++ string
