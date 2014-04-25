
ws = require("./index")

ws.connect "localhost", 3000
ws.onopen -> console.log "opened"

ws.on "greet", (data) -> console.log data

ws.on "delay", (data) -> console.log "delay", data

setTimeout (-> ws.emit "call", "from client"), 1000

ws.on "repeat", (data) ->
  setTimeout (-> ws.emit "repeat", data), 1000
  console.log "have data", data