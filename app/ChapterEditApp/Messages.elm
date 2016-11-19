module ChapterEditApp.Messages exposing (..)

import Http
import Json.Encode
import Time exposing (Time)

import Common.Models exposing (Character, Narration)
import ChapterEditApp.Models exposing (..)
import ChapterEditApp.Ports

type Msg
  = NoOp
  | ChapterFetchError Http.Error
  | ChapterFetchSuccess Chapter
  | NarrationFetchError Http.Error
  | NarrationFetchSuccess Narration
  | UpdateChapterTitle String
  | UpdateEditorContent Json.Encode.Value
  | UpdateNewImageUrl String
  | AddImage
  | AddNewMentionCharacter Character
  | RemoveNewMentionCharacter Character
  | AddMention
  | AddParticipant Character
  | RemoveParticipant Character
  | UpdateSelectedBackgroundImage String
  | UpdateSelectedAudio String
  | OpenMediaFileSelector String
  | AddMediaFile String
  | AddMediaFileError ChapterEditApp.Ports.FileUploadError
  | AddMediaFileSuccess ChapterEditApp.Ports.FileUploadSuccess
  | PlayPauseAudioPreview
  | SaveChapter
  | SaveChapterError Http.RawError
  | SaveChapterSuccess Http.Response
  | SaveNewChapter
  | SaveNewChapterError Http.RawError
  | SaveNewChapterSuccess Http.Response
  | PublishChapter
  | PublishChapterWithTime Time
  | PublishNewChapter
  | PublishNewChapterWithTime Time