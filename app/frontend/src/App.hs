{-# LANGUAGE DeriveAnyClass #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module App (App(..)) where

import Pure.Admin
import Pure.Conjurer as C
import Pure.Elm.Application hiding (goto)
import Pure.Elm.Component hiding (App)
import qualified Pure.WebSocket as WS

import Shared

data App = App 
  { socket :: WS.WebSocket }

instance Application App where
  data Route App 
    = HomeR 
    | BlogR (C.Route Post)
  
  home = HomeR

  location = \case
    HomeR -> "/"
    BlogR r -> C.location r

  routes = do
    C.routes BlogR
    dispatch HomeR

  view route App { socket } _ = 
    Div <||>
      [ case route of
        HomeR -> Null
        BlogR r -> pages @Admin socket r
      ]

instance Fieldable Content where
  field onchange initial = Textarea <| OnInput (withInput onchange) |> [ txt initial ]
instance Theme Post
instance Formable (Resource Post)
instance Readable Post
instance Creatable Admin Post
instance Updatable Admin Post
instance Listable Post

instance Component (Product Post) where
  view Post {..} _ =
    Article <||>
      [ H1  <||> [ txt title ]
      , Div <||> [ txt content ]
      ]

instance Component (Preview Post) where
  view PostPreview {..} _ =
    Article <||>
      [ H1  <||> [ txt title ]
      , Div <||> [ txt synopsis ]
      ]