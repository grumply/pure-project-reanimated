let backend = ../config.dhall
      { name = "backend"
      , synopsis = "backend server"
      }

let deps =
      [ "base"
      , "pure-admin"
      , "pure-conjurer"
      , "pure-json"
      , "pure-elm"
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