
module.exports = ws = {}

routes = {}
ws.on = (key, callback) -> routes[key] = callback

ws.connect = (domain, port) ->
  # domain = domain[...-1] while domain[-1..] is "/"
  if not port?
    port = Number domain
    domain = location.hostname
  socket = new WebSocket "ws://#{domain}:#{port}"

  ws.emit = (key, value) ->
    if ws.closed
      console.log 'WS-JSON: emit when closed'
      return
    socket.send JSON.stringify [key, value]

  socket.onmessage = (event) ->
    data = JSON.parse event.data
    routes[data[0]]? data[1]

  openCalls = []
  ws.onopen = (callback) -> openCalls.push callback
  socket.onopen = -> callback() for callback in openCalls
  
  closeCalls = []
  ws.closed = no
  ws.onclose = (callback) -> closeCalls.push callback
  socket.onclose = ->
    ws.closed = yes
    callback() for callback in closeCalls

  ws

module