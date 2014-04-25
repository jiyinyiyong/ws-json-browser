
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

client.connect "localhost", 3000, (ws) ->

  ws.emit 'greet', text: 'nothing'

  ws.on "repeat", (data) ->
    setTimeout (-> ws.emit "repeat", data), 1000
    console.log "have data", data

  ws.onclose ->
    console.log 'server disturbed'
```

### API

* `ws.connect`: `domain, port, (ws) ->`,
`domain` is optional and defaults to be `location.hostname`
* `ws.onclose`: `->`
* `ws.on`: `key, (value) ->`
* `ws.emit`: `key, value`
* `ws.closed`

### Protocol

This implementation is simple, just using `[key, value]` as JSON.

### Development

Read `make.coffee` for more.