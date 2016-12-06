port module Main exposing (..)


import Html.Attributes
import Html.Events
import Html exposing ( Html )
import Json.Decode as Json

import Polymer.App
import Polymer.Attributes
import Polymer.Paper


port ironSelect : (Int -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
  [ ironSelect IronSelect
  ]


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


type alias Model =
  { selected : Int
  }


defaultModel : Model
defaultModel =
  { selected = 0
  }


type Msg
  = IronSelect Int


init : (Model, Cmd m)
init =
  defaultModel ! []


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =

  case msg of

    IronSelect index ->
      { model
        | selected = index
      } !
      []


view : Model -> Html Msg
view model =
  Html.div
  []
  [ Polymer.Paper.menu
    [ Html.Attributes.id "menu"
    ]
    [ Polymer.Paper.item
      [ Html.Attributes.id "item1" ]
      [ Html.text "Item 1" ]
    , Polymer.Paper.item
      []
      [ Html.text "Item 2" ]
    , Polymer.Paper.item
      []
      [ Html.text "Item 3" ]
    , Polymer.Paper.item
      []
      [ Html.text "Item 4" ]
    ]
    , Html.div
      []
      [ Html.text <| "selected item: " ++ (toString model.selected) ]
  ]
