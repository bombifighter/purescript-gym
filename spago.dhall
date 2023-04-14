{ name = "purescript-gym"
, dependencies =
  [ "aff"
  , "console"
  , "datetime"
  , "effect"
  , "httpure"
  , "maybe"
  , "mysql"
  , "prelude"
  , "simple-json"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
