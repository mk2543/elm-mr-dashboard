module Model.Model exposing(..)

type alias Model =
    {
        gitlabUrl: String
        , mergeRequests: List MergeRequest
    }

type alias MergeRequest = 
  {
    id: String
    , name: String
  }
type Msg
    = NoOp    