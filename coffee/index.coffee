
exports.connect = (args...) ->
  if args.length is 3
    domain = args[0]
    port = args[1]
    handle = args[2]
  else if args.length is 2
    domain = location.hostname
    port = args[0]
    handle = args[1]
  else
    throw new Error "WS-JSON: wrong args: #{args}"

  routes = {}
  ws = {}
  ws.on = (key, callback) -> routes[key] = callback
  socket = new WebSocket "ws://#{domain}:#{port}"

  ws.emit = (key, value) ->
    if ws.closed
      console.log 'WS-JSON: emit when closed'
      return
    socket.send JSON.stringify [key, value]

  socket.onmessage = (event) ->
    data = JSON.parse event.data
    routes[data[0]]? data[1]
  
  closeCalls = []
  ws.closed = no
  ws.onclose = (callback) -> closeCalls.push callback
  socket.onclose = ->
    ws.closed = yes
    callback() for callback in closeCalls

  socket.onopen = ->
    handle ws
