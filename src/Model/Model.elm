module Model.Model exposing(..)
import Http
import Json.Decode exposing (Decoder, field, string)


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

type Msg = ToggleApprovedMrs | ToggleFailedPipelines | ToggleWips | GetMergeRequests | MergeRequestsRetrieved (Result Http.Error String)

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
    , expect= Http.expectJson MergeRequestsRetrieved mrDecoder
    }


mrDecoder : Decoder String
mrDecoder =
  field "data" (field "image_url" string)