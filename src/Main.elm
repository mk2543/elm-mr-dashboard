module Main exposing (..)

import Browser
import View.Layout exposing(view)
import Model.Model exposing(Model, Msg, update)


---- MODEL ----

init : ( Model, Cmd Msg )
init =
   let mr1 = { id = "123"
            , name = "Merge Request 1"
            , appType = Model.Model.Frontend
            , author = "Scarlett Johansson"
            , openSince = "2019-11-13 14:34:33Z"
            , approvals = 2
            , pipelinePassed = Model.Model.Passed
            , changedFiles = 30
        } 

       mr2 = { id = "456"
            , name = "Merge Request 2"
            , appType = Model.Model.Frontend
            , author = "Chris Evans"
            , openSince = "2019-11-15 09:43:12Z"
            , approvals = 1
            , pipelinePassed = Model.Model.Passed
            , changedFiles = 12
        }     

       mr3 = { id = "456"
            , name = "WIP: Merge Request 3"
            , appType = Model.Model.Frontend
            , author = "Chris Evans"
            , openSince = "2019-11-10 10:02:13Z"
            , approvals = 1
            , pipelinePassed = Model.Model.Failed
            , changedFiles = 4
        }     

       mr4 = { id = "456"
            , name = "WIP: Merge Request 4"
            , appType = Model.Model.Frontend
            , author = "Robert Downey Jr."
            , openSince = "2019-11-15 08:06:56Z"
            , approvals = 1
            , pipelinePassed = Model.Model.Warning
            , changedFiles = 4
        }     
       filters = { approvedMrsVisible = True
            , failedPipelinesVisible =  True
            , wipsVisible = True
        }   
       initialModel = {gitlabUrl = "TODO", mergeRequests = [mr1, mr2, mr3, mr4], filters = filters}
    in ( initialModel, Cmd.none )

---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
