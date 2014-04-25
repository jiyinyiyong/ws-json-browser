 
project = 'repo/ws-json-browser'
station = undefined
interval = interval: 300
 
require 'shelljs/make'
browserify = require 'browserify'
 
fs = require 'fs'
 
startTime = (new Date).getTime()
 
reload = -> station?.reload project
 
compileCoffee = (name, callback) ->
  exec "coffee -o js/ -bc coffee/#{name}", ->
    console.log "done: coffee, compiled coffee/#{name}"
    do callback
 
targetBrowserify = ->
  b = browserify ['./js/main']
  build = fs.createWriteStream 'build/build.js', 'utf8'
  bundle = b.bundle(debug: yes)
  bundle.pipe build
  bundle.on 'end', ->
    console.log 'done: browserify'
    do reload
 
target.js = ->
  exec 'coffee -o js/ -bc coffee/'
 
target.compile = ->
  exec 'coffee -o js/ -bc coffee/', ->
    targetBrowserify()
 
target.watch = ->
  fs.watch 'coffee/', interval, (type, name) ->
    if type is 'change'
      compileCoffee name, ->
        do targetBrowserify
  
  station = require 'devtools-reloader-station'
  station.start()
 
process.on 'exit', ->
  now = (new Date).getTime()
  duration = (now - startTime) / 1000
  console.log "\nfinished in #{duration}s"