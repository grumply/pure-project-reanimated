{-# OPTIONS_GHC -fno-warn-orphans #-}
module Connection 
  ( Connection(..)
  ) where

import Pure.Admin as Admin
import Pure.Conjurer
import Pure.Elm.Component as Pure
import Pure.WebSocket as WS

import Shared

data Connection = Connection 
  { admin :: Username
  , socket :: WebSocket 
  }

instance Component Connection where
  data Model Connection = Model { adminToken :: Maybe (Token Admin) }

  model = Model Nothing

  data Msg Connection = Startup | AdminTokenMsg AdminTokenMsg

  startup = [Startup]

  upon Startup Connection { admin = a, socket } mdl = do
    enact socket (Admin.admin AdminTokenMsg a)
    enact socket (resourceReadingBackend @Post postPermissions postCallbacks) 
    activate socket
    pure mdl

  upon (AdminTokenMsg tm) Connection { socket } mdl@Model { adminToken } = case tm of
    GetToken withToken -> withToken adminToken >> pure mdl
    ClearToken -> do
      WS.remove socket (resourcePublishingAPI @Post)
      pure mdl { adminToken = Nothing }
    SetToken t@(Token (un,_)) -> do
      enact socket (resourcePublishingBackend @Post un postPermissions postCallbacks)
      pure mdl { adminToken = Just t }

instance Previewable Post where
  preview RawPost {..} _ = pure PostPreview {..}

instance Producible Post where
  produce RawPost {..} = pure Post {..}

postPermissions :: Permissions Post
postPermissions = def

postCallbacks :: Callbacks Post
postCallbacks = def