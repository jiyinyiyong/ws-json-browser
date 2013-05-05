
ws-json adds a little abstraction to websocket
------

JS prefers JSON-like objects while WebScokets uses strings,  
I made this module to make WebSockets easier for JS.  
Read `ws-json-server` for the server part.  
Note that this is only a demo, it hasn't been tested.  

### Usage

Run `npm install ws-json-client` to install that.  
This module is built based on Browserify, you need to note that.  

```coffee
delay = (t, f) -> setTimeout f, t

ws = require("../lib/index")
ws.connect "192.168.1.14", 3000
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
```

### API

* `ws.connect`: accepts hostname and port

If you only pass a port, the hostname name will be `localtion.hostname`

* `ws.onopen ->`: accepts a callback as a parameter

* `ws.on`: accepts a key and a callback function

* `ws.emit`: accepts a key and a value

### Develop

I use `node-dev dev.coffee` to debug this module