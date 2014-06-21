
client = require("./index")

client.connect "localhost", 3000, (ws) ->

  ws.emit 'greet', 'hello server', (data) ->
    console.log 'server returns:', data

  ws.on 'welcome', (data, res) ->
    console.log 'server say:', data
    res 'got it'

  ws.on "repeat", (data, res) ->
    setTimeout (-> res data), 2000
    console.log "repeat", data

  ws.emit 'repeat', 20

  ws.onclose ->
    console.log 'server disturbed'

  ws.on 'repeat', (n) ->
    console.log 'another:', n