module Shared (module Export, module Shared) where

import Shared.MyApp as Export
import Shared.Post as Export

import Pure.Magician.Client

type instance Resources MyApp = '[Post]

instance Client MyApp

instance Server MyApp where
  type Discussions MyApp = '[Post]

