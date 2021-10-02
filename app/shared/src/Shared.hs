{-# language DerivingStrategies, RecordWildCards, TypeFamilies, DeriveGeneric, DeriveAnyClass, CPP, DuplicateRecordFields #-}
module Shared where

import Pure.Data.Txt
import Pure.Data.JSON
import Pure.Conjurer
import Pure.Conjurer.Form
import Pure.Router

import Data.Hashable

import GHC.Generics

data Post

data instance Identifier Post = PostName Txt
  deriving stock Generic
  deriving anyclass (ToJSON,FromJSON,Hashable,Eq)

data instance Resource Post = RawPost
  { post     :: Txt
  , title    :: Txt
  , synopsis :: Txt
  , content  :: Txt
  } deriving stock Generic
    deriving anyclass (ToJSON,FromJSON,Form)

instance Identifiable Resource Post where
  identify RawPost {..} = PostName post

data instance Product Post = Post
  { post     :: Txt
  , title    :: Txt
  , content  :: Txt
  } deriving stock Generic
    deriving anyclass (ToJSON,FromJSON)

instance Identifiable Product Post where
  identify Post {..} = PostName post

data instance Preview Post = PostPreview
  { post     :: Txt
  , title    :: Txt
  , synopsis :: Txt
  } deriving stock Generic
    deriving anyclass (ToJSON,FromJSON)

instance Identifiable Preview Post where
  identify PostPreview {..} = PostName post

instance Routable Post where
  locate (PostName p) = "/" <> p

  route lift = 
    path "/:post" do
      post <- "post"
      dispatch (lift (PostName post))

