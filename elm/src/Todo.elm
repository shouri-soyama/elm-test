module Todo where

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Html.Lazy as HL
import Signal as S
import StartApp

main : Signal H.Html
main =
  StartApp.start { model = model, view = view, update = update }

type alias Model = 
  { form : String
  , posts : List String
  }

model : Model
model = 
  { form = ""
  , posts = []
  }

view : S.Address Action -> Model -> H.Html
view address model = 
  H.div []
  [ H.div [ HA.class "row" ]
    [ H.div [ HA.class "col-md-8" ]
      [ H.input 
        [ HA.type' "text"
        , HA.class "form-control"
        , HE.on "input" HE.targetValue (S.message address << Change)
        ] []
      ]
      , H.div [ HA.class "col-md-4" ]
        [ H.button 
          [ HA.type' "button"
          , HA.class "btn btn-default"
          , HE.onClick address Post
        ] [ H.text "submit" ]
      ]
    ]
  , H.div [ HA.class "row" ]
    [ HL.lazy list model.posts ]
  ]

list : List String -> H.Html
list posts =
  let
    toTr post = H.tr []
      [ H.td [] [ H.text (post) ]
      ]
  in
    H.table
      [ HA.class "table" ]
      [ H.thead []
        [ H.th [ HA.style [ ("width", "100px") ] ] [ H.text "todo" ]
        ]
      , H.tbody [] <| List.map toTr posts
      ]

type Action
  = Change String
  | Post

update : Action -> Model -> Model
update action model =
  case action of
    Change str -> { model | form <- str }
    Post -> { model | posts <- model.form :: model.posts }

