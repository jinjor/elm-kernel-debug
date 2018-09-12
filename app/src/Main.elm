module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Browser.sandbox
        { init = ""
        , update = \msg model -> msg
        , view = \model -> input [ value model, onInput identity ] []
        }
