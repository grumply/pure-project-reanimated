{-# language DerivingStrategies, RecordWildCards, TypeFamilies, DeriveGeneric, DeriveAnyClass, CPP #-}
module Shared where

import Pure.Data.Txt
import Pure.Data.JSON
import Pure.Conjurer
import Pure.Conjurer.Form

import Data.Typeable
import GHC.Generics

data Post deriving Typeable
instance IsResource Post where
  data Resource Post = Post
    { title    :: Txt
    , synopsis :: Txt
    , content  :: Txt
    } deriving stock Generic
      deriving anyclass (ToJSON,FromJSON,Form)

  root = "/blog"

  slug Post {..} = toSlug title
