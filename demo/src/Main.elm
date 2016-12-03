port module Main exposing (..)


import Html.Attributes
import Html.Events
import Html exposing ( Html )
import Json.Decode as Json

import Polymer.App
import Polymer.Attributes
import Polymer.Paper


port openDrawer : () -> Cmd msg
port closeDrawer : () -> Cmd msg


ports =
  { openDrawer = openDrawer
  , closeDrawer = closeDrawer
  }


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }


type alias Model =
  { drawerOpened : Bool
  }


defaultModel : Model
defaultModel =
  { drawerOpened = False
  }


type Msg
  = ToggleDrawer


init : (Model, Cmd m)
init =
  defaultModel ! []


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =

  case msg of

    ToggleDrawer ->
      if model.drawerOpened then
          { model
            | drawerOpened = False
          } !
          [ ports.closeDrawer ()
          ]
        else
          { model
            | drawerOpened = True
          } !
          [ ports.openDrawer ()
          ]


view : Model -> Html Msg
view model =
  Html.div
  []
  [ Polymer.App.header
    []
    [ Polymer.App.toolbar
      []
      [ Polymer.Paper.iconButton
        [ Polymer.Attributes.icon "menu"
        , Html.Events.onClick ToggleDrawer
        ]
        []
      , Html.div
        [ Polymer.Attributes.boolProperty "main-title" True
        ]
        [ Html.text "My app"
        ]
      , Polymer.Paper.iconButton
        [ Polymer.Attributes.icon "delete"
        ]
        []
      , Polymer.Paper.iconButton
        [ Polymer.Attributes.icon "search"
        ]
        []
      , Polymer.Paper.iconButton
        [ Polymer.Attributes.icon "close"
        ]
        []
      , Polymer.Paper.progress
        [ Polymer.Attributes.stringProperty "value" "10"
        , Polymer.Attributes.boolProperty "indeterminate" True
        , Polymer.Attributes.boolProperty "bottom-item" True
        ]
        []
      ]
    ]
  , Html.text (toString model.drawerOpened)
  , let
      _ = Debug.log "model.drawerOpened" model.drawerOpened
    in
      Polymer.App.drawer
      [ Html.Attributes.id "drawer"
      ]
      [
      ]
  ]
