module Main exposing
  ( main
  )


import Html exposing
  ( Html )
import Html.Attributes
import Html.Events
import Json.Decode as Json

import Polymer.App
import Polymer.Paper
import Polymer.Attributes

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }



type alias Model =
  { drawerOpen : Bool
  }

defaultModel : Model
defaultModel =
  { drawerOpen = False
  }


type Msg
  = DrawerToggle
  | AppDrawerAttached
  | AppDrawerResetLayout
  | AppDrawerTransitioned Bool

init : (Model, Cmd m)
init =
  (defaultModel, Cmd.none)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    DrawerToggle ->
      let
        newModel =
          { model
            | drawerOpen = not model.drawerOpen
          }
      in
        (newModel, Cmd.none)

    AppDrawerTransitioned opened ->
      let
        newModel =
          { model
            | drawerOpen = opened
          }
      in
        (newModel, Cmd.none)

    _ ->
      let
          _ = Debug.log "msg" msg
      in
          model ! []



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
        , Html.Attributes.attribute "onclick" "document.getElementById('drawer').toggle()"
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
  , let
      _ = Debug.log "model.drawerOpen" model.drawerOpen
    in
      Polymer.App.drawer
      [ Html.Attributes.id "drawer"
      , Html.Events.on "app-drawer-attached" (Json.succeed AppDrawerAttached)
      , Html.Events.on "app-drawer-reset-layout" (Json.succeed AppDrawerResetLayout)
      , Html.Events.on "app-drawer-transitioned" (Json.map AppDrawerTransitioned (Json.at ["target", "opened" ] Json.bool))
      ]
--    ( List.filterMap identity
--      [ Html.Attributes.attribute "opened" "opened"
--        |> if model.drawerOpen then Just else always Nothing
--      ]
--    )
    []
  ]
