module Core.Models exposing (..)

import Routing
import ReaderApp
import CharacterApp
import NarratorDashboardApp
import NarrationCreationApp
import NarrationOverviewApp
import ChapterEditApp
import ChapterControlApp
import CharacterCreationApp
import UserManagementApp

type alias UserInfo =
  { id : Int
  , email : String
  , role : String
  }

type UserSession
  = AnonymousSession
  | LoggedInSession UserInfo

type alias Model =
  { route : Routing.Route
  , session : Maybe UserSession
  , email : String
  , password : String

  , readerApp : ReaderApp.Model
  , characterApp : CharacterApp.Model
  , narratorDashboardApp : NarratorDashboardApp.Model
  , narrationCreationApp : NarrationCreationApp.Model
  , narrationOverviewApp : NarrationOverviewApp.Model
  , chapterEditApp : ChapterEditApp.Model
  , chapterControlApp : ChapterControlApp.Model
  , characterCreationApp : CharacterCreationApp.Model
  , userManagementApp : UserManagementApp.Model
  }