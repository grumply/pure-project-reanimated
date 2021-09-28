module Connection 
  ( Connection(..)
  ) where

import Pure.Admin as Admin
import Pure.Conjurer
import Pure.Elm.Component as Pure
import Pure.WebSocket as WS

import Shared

data Connection = Connection { admin :: Username, socket :: WebSocket }

instance Component Connection where
  data Model Connection = Model { adminToken :: Maybe (Token Admin) }

  model = Model Nothing

  data Msg Connection = Startup | AdminTokenMsg AdminTokenMsg

  startup = [Startup]

  upon Startup Connection { admin = a, socket } mdl = do
    enact socket (Admin.admin AdminTokenMsg a)
    enact socket (resourceBackend @Post postPermissions defaultCallbacks) 
    activate socket
    pure mdl

  upon (AdminTokenMsg tm) _ mdl@Model { adminToken } = case tm of
    GetToken withToken -> withToken adminToken >> pure mdl
    ClearToken -> pure mdl { adminToken = Nothing }
    SetToken t -> pure mdl { adminToken = Just t }

postPermissions :: Elm (Msg Connection) => Permissions Post
postPermissions = Permissions {..}
  where
    canCreate _ = isAdmin AdminTokenMsg
    canRead   _ = pure True
    canUpdate _ = isAdmin AdminTokenMsg
    canDelete _ = isAdmin AdminTokenMsg
    canList     = isAdmin AdminTokenMsg