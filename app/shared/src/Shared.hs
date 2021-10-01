{-# language DerivingStrategies, RecordWildCards, TypeFamilies, DeriveGeneric, DeriveAnyClass, CPP, DuplicateRecordFields #-}
module Shared where

import Pure.Data.Txt
import Pure.Data.JSON
import Pure.Conjurer
import Pure.Conjurer.Form

import Data.Hashable

import GHC.Generics

data Post
instance IsResource Post where

  data Identifier Post = PostName Txt
    deriving stock Generic
    deriving anyclass (ToJSON,FromJSON,Hashable,Eq)

  data Resource Post = RawPost
    { post     :: Txt
    , title    :: Txt
    , synopsis :: Txt
    , content  :: Txt
    } deriving stock Generic
      deriving anyclass (ToJSON,FromJSON,Form)

  identifyResource RawPost {..} = PostName post

  data Product Post = Post
    { post     :: Txt
    , title    :: Txt
    , synopsis :: Txt
    , content  :: Txt
    } deriving stock Generic
      deriving anyclass (ToJSON,FromJSON)
      
  identifyProduct Post {..} = PostName post

  data Preview Post = PostPreview
    { post     :: Txt
    , title    :: Txt
    , synopsis :: Txt
    } deriving stock Generic
      deriving anyclass (ToJSON,FromJSON)


  identifyPreview PostPreview {..} = PostName post
