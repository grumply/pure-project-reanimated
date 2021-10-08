{-# LANGUAGE DeriveAnyClass #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module App (App(..)) where

import Pure.Admin
import Pure.Conjurer
import Pure.Elm.Application hiding (goto)
import Pure.Elm.Component hiding (App)
import qualified Pure.WebSocket as WS

import Shared

data App = App 
  { socket :: WS.WebSocket }

instance Application App where
  data Route App 
    = HomeR 
    | BlogR (ResourceRoute Admin Post)
  
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
        BlogR r -> resourcePages @Admin socket r
      ]

instance Formable (Resource Post)
instance Readable Post
instance Creatable Admin Post
instance Updatable Admin Post
instance Listable Post

instance Component (KeyedPreview Post) where
  view (KeyedPreview ctx nm PostPreview {..}) _ =
    Article <| OnClick (\_ -> goto (ReadR @Admin ctx nm)) |>
      [ H1  <||> [ txt title ]
      , Div <||> [ txt synopsis ]
      ]

instance Component (Product Post) where
  view Post {..} _ =
    Article <||>
      [ H1  <||> [ txt title ]
      , Div <||> [ txt content ]
      ]