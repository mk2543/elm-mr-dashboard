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
    , approvedByMe: Bool
    , isWip: Bool
    , pipelinePassed: PipelineStatus
    , changedFiles: Int
  }

type alias Filters = {
    approvedMrsVisible: Bool
    , failedPipelinesVisible: Bool
    , wipsVisible: Bool
  }  

type FilterMessages = HideApprovedMrs | ShowApprovedMrs | HideFailedPipelines 
  | ShowFailedPipelines | HideWips | ShowWips | ClearFilters

type Msg
    = Merge MrId | FilterMessages    