
delay = (t, f) -> setTimeout f, t

ws = require("../lib/index")
ws.connect 3000
ws.onopen -> console.log "opened"
ws.on "greet", (data) ->
  console.log data

ws.on "delay", (data) ->
  console.log "delay", data

console.log "start"
delay 1000, ->
  ws.emit "call", "from client"

ws.on "repeat", (data) ->
  ws.emit "repeat", data
  console.log "have data", data