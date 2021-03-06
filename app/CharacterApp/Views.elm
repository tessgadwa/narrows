module CharacterApp.Views exposing (mainView)

import Html exposing (Html, main_, section, h2, h3, div, ul, li, img, input, button, a, label, em, text)
import Html.Attributes exposing (id, class, for, src, href, type_, value, checked)
import Html.Events exposing (onClick, onInput, on)

import Json.Decode

import Common.Views exposing (bannerView, linkTo)
import CharacterApp.Models exposing (Model, CharacterInfo, ChapterSummary)
import CharacterApp.Messages exposing (..)


avatarUrl : Int -> Maybe String -> String
avatarUrl narrationId maybeAvatar =
  case maybeAvatar of
    Just avatar ->
      "/static/narrations/" ++ (toString narrationId) ++ "/avatars/" ++ avatar
    Nothing ->
      "/img/default-avatar.png"


chapterParticipation : String -> ChapterSummary -> Html Msg
chapterParticipation characterToken chapter =
  li []
    [ a
      (linkTo
        NavigateTo
        ("/read/" ++ (toString chapter.id) ++ "/" ++ characterToken)
      )
      [ text chapter.title ]
    ]


mainView : Model -> Html Msg
mainView model =
  main_ [ id "reader-app", class "app-container" ]
    [ h2 []
      (case model.characterInfo of
        Just characterInfo ->
          [ text <| characterInfo.name ++ ", character in "
          , em [] [ text characterInfo.narration.title ]
          ]

        Nothing ->
          [ text "Loading"
          ]
      )
    , bannerView model.banner
    , div [ class "two-column" ]
        [ section []
            [ case model.characterInfo of
              Just characterInfo ->
                div []
                  [ div [ class "avatars" ]
                      [ div [ class "current-avatar" ]
                          [ img [ src <| avatarUrl characterInfo.narration.id characterInfo.avatar ] []
                          ]
                      , div [ class "upload-new-avatar" ]
                          [ div [ class "new-avatar-controls" ]
                              [ label [] [ text "Upload new avatar:" ]
                              , input [ id "new-avatar"
                                      , type_ "file"
                                      , on "change" (Json.Decode.succeed <| UpdateCharacterAvatar "new-avatar")
                                      ]
                                  []
                              ]
                          , img [ src <| case model.newAvatarUrl of
                                           Just url -> url
                                           Nothing -> "/img/default-avatar.png"
                                ]
                              []
                          ]
                      ]
                  , label [] [ text "Name" ]
                  , div []
                      [ input [ type_ "text"
                              , class "character-name editor-container"
                              , value characterInfo.name
                              , onInput UpdateCharacterName
                              ]
                          []
                      ]
                  ]

              Nothing ->
                text "Loading…"
            , label [] [ text "Description" ]
            , div [ id "description-editor"
                  , class "editor-container"
                  ] []
            , label [] [ text "Backstory" ]
            , div [ id "backstory-editor"
                  , class "editor-container"
                  ] []
            , div [ class "btn-bar" ]
                [ button
                  [ class "btn btn-default"
                  , onClick SaveCharacter
                  ]
                  [ text "Save" ]
                ]
            ]
        , section []
            [ h3 [] [ text "Appears in these chapters:" ]
            , case model.characterInfo of
              Just characterInfo ->
                ul []
                  (List.map (chapterParticipation model.characterToken)
                    characterInfo.narration.chapters
                  )

              Nothing ->
                em [] [ text "None." ]
            ]
        ]
    ]
