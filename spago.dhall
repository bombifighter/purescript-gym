{ name = "purescript-gym"
, dependencies =
  [ "aff"
  , "console"
  , "datetime"
  , "effect"
  , "maybe"
  , "mysql"
  , "prelude"
  , "yoga-json"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
