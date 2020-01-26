module Model.Model exposing(..)

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

type Msg = ToggleApprovedMrs | ToggleFailedPipelines | ToggleWips 

updateToggles: Msg -> Filters -> Filters
updateToggles msg filters = 
    case msg of
        ToggleApprovedMrs -> { filters | approvedMrsVisible = not filters.approvedMrsVisible }
        ToggleFailedPipelines -> { filters | failedPipelinesVisible = not filters.failedPipelinesVisible }   
        ToggleWips -> { filters | wipsVisible = not filters.wipsVisible }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( { model | filters = updateToggles msg model.filters }, Cmd.none )
