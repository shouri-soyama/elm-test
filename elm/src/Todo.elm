module Todo where

import Html as H
import Html.Attributes as HA
import StartApp

main : Signal Html
main =
  StartApp.start { model = model, view = view, update = update }

type alias Model = List String 

model : Model
model = []

view : Address action -> Model -> Html
view address model = 
  H.div [ HA.class "row" ]
  [ H.input [] []
  , H.button [] []
  ]

type Action = Post String

update : Action -> Model -> Model
update action model =
  case action of
    Post str -> str :: model

