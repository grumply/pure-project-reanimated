module App (App(..)) where

import Pure
import Pure.Conjurer as C
import Pure.Elm.Application as A
import Pure.Elm.Component
import Pure.Magician.Client (useSocket)
import qualified Pure.WebSocket.Cache as WS

import Shared

instance Application MyApp where
  data Route MyApp = NoneR | HomeR
  
  home = NoneR

  title = \case
    NoneR -> Nothing
    HomeR -> Just "My App"
  
  routes = do
    A.match "/" HomeR
    A.continue

  view route _ _ = 
    case route of
      NoneR -> Null
      HomeR -> 
        Div <||>
          [ A <| ref (CreateR PostContext) |> [ "New Post" ]
          , useSocket @MyApp $ \ws -> toList ws PostContext
          ]

instance Fieldable Content where
  field onchange initial = Textarea <| OnInput (withInput onchange) |> [ txt initial ]

instance Readable Post 
instance Listable Post

instance Pure (Product Post) where
  view Post {..} =
    Article <||>
      [ H1  <||> [ txt title ]
      , Div <||> [ txt content ]
      ]

instance Pure (Preview Post) where
  view PostPreview {..} =
    Article <||>
      [ H1  <||> [ txt title ]
      , Div <||> [ txt synopsis ]
      ]