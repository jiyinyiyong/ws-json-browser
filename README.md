
`ws-json-browser` adds a little abstraction to websocket
------

EventEmitter like API for WebSocket, in browser-side.

### Usage

This module is writtern in CommonJS protocol.
You need to use Browserify to package code in browsers.

```bash
npm install ws-json-browser
```

```coffee
ws = require "ws-json-browser"

ws.connect "localhost", 3000

ws.onopen -> console.log "opened"
ws.onopen -> console.log "opened"

ws.on "greet", (data) -> console.log data

ws.on "delay", (data) -> console.log "delay", data

setTimeout (-> ws.emit "call", "from client"), 1000

ws.on "repeat", (data) ->
  ws.emit "repeat", data
  console.log "have data", data
```

### API

* `ws.connect`: `port`
* `ws.onopen`: `->`
* `ws.onclose`: `->`
* `ws.on`: `key, (value) ->`
* `ws.emit`: `key, value`
* `ws.closed`

### Protocol

This implementation is simple, just using `[key, value]` as JSON.

### Development

Read `make.coffee` for more.