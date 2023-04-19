{ name = "purescript-gym"
, dependencies =
  [ "aff"
  , "arrays"
  , "console"
  , "datetime"
  , "effect"
  , "either"
  , "formatters"
  , "httpure"
  , "integers"
  , "maybe"
  , "mysql"
  , "node-process"
  , "now"
  , "partial"
  , "posix-types"
  , "prelude"
  , "simple-json"
  , "strings"
  , "tuples"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
