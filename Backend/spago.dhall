{ name = "purescript-gym"
, dependencies =
  [ "aff"
  , "arrays"
  , "console"
  , "datetime"
  , "effect"
  , "httpure"
  , "integers"
  , "maybe"
  , "mysql"
  , "node-process"
  , "posix-types"
  , "prelude"
  , "simple-json"
  , "tuples"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
