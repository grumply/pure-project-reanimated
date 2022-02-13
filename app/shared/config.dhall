let shared = ../config.dhall
      { name = "shared"
      , synopsis = "shared types and apis" 
      }
in
  shared //
    { dependencies =
        [ "base"
        , "pure"
        , "pure-auth"
        , "pure-conjurer"
        , "pure-convoker"
        , "pure-default"
        , "pure-elm"
        , "pure-json"
        , "pure-magician"
        , "pure-render"
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
