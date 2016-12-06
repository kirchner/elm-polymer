port module Main exposing (..)


import Dict

import Html.Attributes
import Html.Events
import Html exposing ( Html )
import Json.Decode as Json

import Polymer.App
import Polymer.Attributes
import Polymer.Paper

import Parts


import Menu


port ironSelect : (Int -> msg) -> Sub msg


--subscriptions : Model -> Sub Msg
--subscriptions model =
--  Sub.batch
--  [ ironSelect IronSelect
--  ]


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
  [ Sub.map PolymerMsg (Menu.subscriptions model)
  ]


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = Menu.subscriptions 
    }


type alias Model =
  { selected : Int
  , menu : Menu.Indexed Menu.Model
  }


defaultModel : Model
defaultModel =
  { selected = 0
  , menu = Dict.empty
  }


type Msg
  = IronSelect Int
  | PolymerMsg (Parts.Msg Model Msg)


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

    PolymerMsg polymerMsg ->
      Parts.update polymerMsg model



view : Model -> Html Msg
view model =
  Html.div
  []
  [ Menu.render PolymerMsg [0] model
    [ Menu.item
      []
      [ Html.text "Item 1" ]
    , Menu.item
      []
      [ Html.text "Item 2" ]
    , Menu.item
      []
      [ Html.text "Item 3" ]
    , Menu.item
      []
      [ Html.text "Item 4" ]
    ]
    , Html.div
      []
      [ Html.text <| "selected item: " ++ (toString model.selected) ]
  ]
