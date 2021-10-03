{-# language DerivingStrategies, RecordWildCards, TypeFamilies, DeriveGeneric, DeriveAnyClass, CPP, DuplicateRecordFields #-}
module Shared where

import Pure.Data.Txt
import Pure.Data.JSON
import Pure.Conjurer
import Pure.Conjurer.Form

import Data.Hashable

import GHC.Generics

data Post

data instance Identifier Post = PostName (Slug Post)
  deriving stock Generic
  deriving anyclass (ToJSON,FromJSON,Hashable,Eq)

data instance Resource Post = RawPost
  { post     :: Slug Post
  , title    :: Txt
  , synopsis :: Txt
  , content  :: Txt
  } deriving stock Generic
    deriving anyclass (ToJSON,FromJSON,Form)

instance Identifiable Resource Post where
  identify RawPost {..} = PostName post

data instance Product Post = Post
  { title    :: Txt
  , content  :: Txt
  } deriving stock Generic
    deriving anyclass (ToJSON,FromJSON)

data instance Preview Post = PostPreview
  { post     :: Slug Post
  , title    :: Txt
  , synopsis :: Txt
  } deriving stock Generic
    deriving anyclass (ToJSON,FromJSON)

instance Identifiable Preview Post where
  identify PostPreview {..} = PostName post
