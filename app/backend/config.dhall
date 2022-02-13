let backend = ../config.dhall
      { name = "backend"
      , synopsis = "backend server"
      }

let deps =
      [ "base"
      , "pure"
      , "pure-conjurer"
      , "pure-convoker"
      , "pure-json"
      , "pure-elm"
      , "pure-magician"
      , "pure-server"
      , "pure-sorcerer"
      , "pure-websocket"
      , "shared"
      , "yaml"
      ]

in
  backend //
    { dependencies = deps
    , executables =
        { backend =
          { source-dirs = [ "src" ]
          , main = "Main.hs"
          , dependencies = deps
          } 
        }
    }