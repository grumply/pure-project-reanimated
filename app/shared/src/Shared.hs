{-# language DerivingStrategies, RecordWildCards, TypeFamilies, DeriveGeneric, DeriveAnyClass, CPP, DuplicateRecordFields #-}
module Shared where

import Pure.Data.Default
import Pure.Data.JSON
import Pure.Data.Txt
import Pure.Conjurer

import Data.Hashable

import GHC.Generics

data Post

newtype Content = Content Txt
  deriving (ToTxt,FromTxt,ToJSON,FromJSON) via Txt

data instance Resource Post = RawPost
  { title    :: Txt
  , synopsis :: Content
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
