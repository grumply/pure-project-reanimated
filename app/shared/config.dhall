let shared = ../config.dhall
      { name = "shared"
      , synopsis = "shared types and apis" 
      }
in
  shared //
    { dependencies =
        [ "base"
        , "pure"
        , "pure-conjurer"
        , "pure-json"
        , "pure-router"
        , "pure-txt"
        , "pure-websocket"
        , "hashable"
        ]
    , library = 
        { source-dirs = ["src"]
        , other-modules = [] : List Text
        }
    }
