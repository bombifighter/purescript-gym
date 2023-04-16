{ name = "purescript-gym"
, dependencies =
  [ "aff"
  , "arrays"
  , "console"
  , "datetime"
  , "effect"
  , "httpure"
  , "integers"
  , "node-process"
  , "maybe"
  , "mysql"
  , "posix-types"
  , "prelude"
  , "simple-json"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
