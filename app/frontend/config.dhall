let frontend = ../config.dhall
      { name = "frontend"
      , synopsis = "frontend client" 
      }

let deps = 
      [ "base"
      , "pure"
      , "pure-auth"
      , "pure-conjurer"
      , "pure-elm"
      , "pure-magician"
      , "pure-websocket"
      , "pure-websocket-cache"
      , "shared"
      ]

in
  frontend //
    { dependencies = deps
    , executables =
        { frontend =
          { source-dirs = [ "src" ]
          , main = "Main.hs"
          , dependencies = deps
          } 
        }
    }
