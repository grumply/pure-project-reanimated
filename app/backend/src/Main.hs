module Main where

import Shared

import Pure
import Pure.Elm.Component
import Pure.Conjurer
import Pure.Convoker.Discussion.Simple.Threaded
import Pure.Magician.Server

main = do
  serve @MyApp defaultUserConfig

instance Previewable Post where
  preview _ _ _ RawPost {..} _ = 
    pure PostPreview 
      { title = toTxt title
      , synopsis = toTxt synopsis
      }

instance Producible Post where
  produce _ context name RawPost {..} _ = 
    pure Post 
      { title = toTxt title
      , content = toTxt content
      }

instance Pure (Product Post) where
  view Post {..} =
    Article <||>
      [ Header  <||> [ H1 <||> [ txt title ] ]
      , Section <||> [ P  <||> [ txt content ] ]
      ]