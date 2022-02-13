
{-# language DerivingStrategies, DeriveAnyClass, TypeFamilies, DeriveGeneric, DuplicateRecordFields #-}
module Shared.Post where

import Shared.MyApp

import Pure.Auth (Username)
import Pure.Conjurer
import Pure.Convoker
import Pure.Data.Default (Default)
import Pure.Data.JSON (FromJSON, ToJSON)
import Pure.Data.Txt (Txt,FromTxt(..),ToTxt(..))
import Pure.Data.Render ()
import Pure.Elm.Component (View,Time)

import Data.Hashable

import GHC.Generics

data Post

newtype Content = Content Txt
  deriving stock (Generic) 
  deriving (ToTxt,FromTxt,ToJSON,FromJSON) via Txt

newtype Synopsis = Synopsis Txt
  deriving stock (Generic) 
  deriving (ToTxt,FromTxt,ToJSON,FromJSON) via Txt

data instance Resource Post = RawPost
  { title    :: Txt
  , synopsis :: Synopsis
  , content  :: Content
  } deriving stock Generic
    deriving anyclass (ToJSON,FromJSON,Default)

data instance Context Post = PostContext
  deriving stock (Generic,Eq,Ord)
  deriving anyclass (ToJSON,FromJSON,Pathable,Hashable)

data instance Name Post = PostName (Slug Post)
  deriving stock (Generic,Eq,Ord)
  deriving anyclass (ToJSON,FromJSON,Pathable,Hashable)

instance Nameable Post where
  toName RawPost {..} = PostName (fromTxt (toTxt title))

instance Ownable Post where
  isOwner un _ _ = isAdmin @MyApp un

instance Amendable Post where
  data Amend Post = Id
    deriving stock Generic
    deriving anyclass (ToJSON,FromJSON)

data instance Action Post = NoPostAction
  deriving stock Generic
  deriving anyclass (ToJSON,FromJSON)

data instance Reaction Post = NoPostReaction
  deriving stock Generic
  deriving anyclass (ToJSON,FromJSON)

data instance Product Post = Post
  { title    :: Txt
  , content  :: Txt
  } deriving stock Generic
    deriving anyclass (ToJSON,FromJSON)

data instance Preview Post = PostPreview
  { title    :: Txt
  , synopsis :: Txt
  } deriving stock Generic
    deriving anyclass (ToJSON,FromJSON)
