
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
client = require "ws-json-browser"

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
```

### API

Connect to server:

* `client.connect`: `domain, port, (ws) ->`,
`domain` is optional and defaults to be `location.hostname`

Communication is based on `[key, value, id]`:

* `ws.emit`: `key, value, (data) ->`,
`data` is what server callbacked,
both `value` and data are optional.

* `ws.on`: `key, (value, res) ->`,
`res` can be used like `res value` to send data back

When close:

* `ws.onclose`: `->`
* `ws.closed`

Since there might be lots of connections and many instances of `ws`.
`ws` objects may fail to be garbage collected.
To stay away from memory leak, a solution from Backbone.

* `ws.listenTo`: `source, eventName, (value) ->`,
it uses `.removeListener()` internally

### Development

Read `make.coffee` for more.

### Changelog

* `0.0.6`

  * Fix mutiple listeners on the same event name