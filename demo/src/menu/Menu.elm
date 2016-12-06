port module Menu exposing
  ( Model
  , Indexed
  , render
  , item
  , subscriptions
  )


import Html exposing
  ( Attribute
  , Html
  )

import Polymer.Paper

import Parts



type alias Model =
  { selected : Int
  }


initialModel : Model
initialModel =
  { selected = 0
  }


type alias Item m =
  { options : List (Attribute m)
  , html : List (Html m)
  }


item : List (Html.Attribute m) -> List (Html m) -> Item m
item options html =
  { options = options
  , html = html
  }



port ironSelect : (Int -> msg) -> Sub msg

subscriptions : Container c -> Sub Msg
subscriptions con =
  Sub.batch
  [ ironSelect IronSelect
  ]



type Msg
  = IronSelect Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =

  case msg of

    IronSelect index ->
      { model
        | selected = index
      } ! []



view : (Msg -> m) -> Model -> List (Item m) -> Html m
view lift model items =
  Html.div
  []
  [ Polymer.Paper.menu
    []
    <| List.map viewItem items
  ]

viewItem : Item m -> Html m
viewItem item =
  Polymer.Paper.item
  item.options
  item.html



type alias Indexed m =
  Parts.Indexed (List Int) m


type alias Index =
  Parts.Index (List Int)


type alias Container c =
  { c
    | menu : Indexed Model
  }


set : Parts.Set (Indexed Model) (Container c)
set m c =
  { c
    | menu = m
  }


render
  : (Parts.Msg (Container c) m -> m)
 -> Index
 -> Container c
 -> List (Item m)
 -> Html m
render =
  Parts.create view (Parts.generalize update) .menu set initialModel


find : Index -> Parts.Accessors Model (Container c)
find =
  Parts.accessors .menu set initialModel
