
u = n: 0, id: -> "b#{@n += 1}"

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

  socket = new WebSocket "ws://#{domain}:#{port}"
  ws = closed: no

  send = (data) ->
    return console.log 'WS-JSON: aleady closed' if ws.closed
    socket.send (JSON.stringify data)
  
  routes = {}
  ws.on = (key, callback) -> routes[key] = callback

  emitCalls = {}
  ws.emit = (key, value, callback) ->
    unless callback?
      callback = value
      value = null
    id = u.id()
    send [key, value, id]
    emitCalls[id] = callback

  socket.onmessage = (event) ->
    [key, value, id] = JSON.parse event.data
    routes[key]? value, (ret) -> send [key, ret, id]
    emitCalls[id]? value

  closeCalls = []
  ws.closed = no
  ws.onclose = (callback) -> closeCalls.push callback
  socket.onclose = ->
    ws.closed = yes
    callback() for callback in closeCalls

  socket.onopen = ->
    handle ws
