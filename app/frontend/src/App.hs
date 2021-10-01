{-# OPTIONS_GHC -fno-warn-orphans #-}
module App (App(..)) where

import Pure.Admin
import Pure.Conjurer
import Pure.Elm.Application hiding (run)
import Pure.Elm.Component hiding (App)
import Pure.WebSocket

import Shared

data App = App 
  { socket :: WebSocket }

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
    dispatch HomeR

  view route App { socket } _ = 
    Div <||>
      [ case route of
        HomeR -> Null
        BlogR r -> resourcePage @Admin socket r
      ]

instance Theme Post

instance Component (Preview Post) where
  view PostPreview {..} _ =
    Article <||>
      [ H1  <||> [ txt title ]
      , Div <||> [ txt synopsis ]
      ]

instance Component (Product Post) where
  view Post {..} _ =
    Article <||>
      [ H1  <||> [ txt title ]
      , Div <||> [ txt content ]
      ]