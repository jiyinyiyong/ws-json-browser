
require("calabash").do "so...",
  "pkill -f doodle"
  "coffee -o lib/ -wbc coffee/"
  "doodle build/"

{exec} = require "child_process"

watcher = require("chokidar").watch "./lib/"
watcher.on "change", (filepath) ->
  console.log filepath, ":: changed"
  exec "browserify -o build/build.js -d lib/test.js"