module Main exposing (..)

import Html exposing (Html, text, div, h1, input, button, ul, li)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode exposing (string)
import Json.Encode as Encode


---- MODEL ----


type alias Model =
    { items : List String
    , newItem : String
    }


init : ( Model, Cmd Msg )
init =
    ( { items = [], newItem = "" }, Cmd.none )



---- UPDATE ----


type Msg
    = Add
    | UpdateNewItem String
    | SaveItem String
    | Saved (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add ->
            ( { model
                | items = model.items ++ [ model.newItem ]
                , newItem = ""
              }
            , saveItem model.newItem
            )

        UpdateNewItem newValue ->
            ( { model | newItem = newValue }, Cmd.none )

        SaveItem item ->
            ( model, Cmd.none )

        Saved (Ok _) ->
            ( model, Cmd.none )

        Saved (Err description) ->
            ( { model | newItem = "ERROR" }, Cmd.none )


saveItem : String -> Cmd Msg
saveItem item =
    let
        request =
            Http.post "http://localhost:3001/todo/item" (encodeItem item) string
    in
        Http.send Saved request


encodeItem : String -> Http.Body
encodeItem item =
    let
        encoded =
            Encode.object
                [ ( "item", Encode.string item )
                ]
    in
        Http.jsonBody encoded



---- VIEW ----


listItem : String -> Html Msg
listItem description =
    li [] [ text description ]


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Your simple Elm TODO list" ]
        , input
            [ onInput UpdateNewItem, value model.newItem ]
            []
        , button [ onClick Add ] [ text "Add item" ]
        , ul [] (List.map listItem model.items)
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
