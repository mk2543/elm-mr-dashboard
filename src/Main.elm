module Main exposing (..)

import Browser
import View.Layout exposing(view)
import Model.Model exposing(Model, Msg, update)


---- MODEL ----

init : ( Model, Cmd Msg )
init =
   let filters = { approvedMrsVisible = True
            , failedPipelinesVisible =  True
            , wipsVisible = True
        }   
       initialModel = {gitlabUrl = "TODO", mergeRequests = [], filters = filters}
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
