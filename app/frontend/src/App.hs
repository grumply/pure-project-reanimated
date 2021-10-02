{-# OPTIONS_GHC -fno-warn-orphans #-}
module App (App(..)) where

import Pure.Admin
import Pure.Conjurer
import Pure.Elm.Application hiding (run,goto)
import Pure.Elm.Component hiding (App)
import qualified Pure.WebSocket as WS

import Shared

data App = App 
  { socket :: WS.WebSocket }

instance Application App where
  data Route App 
    = HomeR 
    | BlogR (ResourceRoute Post)
  
  home = HomeR

  location = \case
    HomeR -> "/"
    BlogR r -> resourceLocation r

  routes = do
    resourceRoutes BlogR
    path "/blog" do
      path "/:post" do
        post <- "post"
        dispatch (BlogR (ReadProduct "admin" (PostName post)))
      dispatch (BlogR (ListPreviews (Just "admin")))
    dispatch HomeR

  view route App { socket } _ = 
    Div <||>
      [ case route of
        HomeR -> Null
        BlogR r -> resourcePage @Admin socket r
      ]

instance Component (Preview Post) where
  view p@PostPreview {..} _ =
    Article <| OnClick (\_ -> goto (ReadProduct "admin" (identify p))) |>
      [ H1  <||> [ txt title ]
      , Div <||> [ txt synopsis ]
      ]

instance Component (Product Post) where
  view Post {..} _ =
    Article <||>
      [ H1  <||> [ txt title ]
      , Div <||> [ txt content ]
      ]