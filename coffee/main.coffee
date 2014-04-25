
client = require("./index")

client.connect "localhost", 3000, (ws) ->

  ws.emit 'greet', text: 'nothing'

  ws.on "repeat", (data) ->
    setTimeout (-> ws.emit "repeat", data), 1000
    console.log "have data", data

  ws.onclose ->
    console.log 'server disturbed'