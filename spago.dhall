{ name = "purescript-gym"
, dependencies =
  [ "console"
  , "effect"
  , "either"
  , "foreign"
  , "prelude"
  , "yoga-json"
  , "integers"
  , "numbers"
  , "maybe"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
