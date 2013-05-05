
route = {}
exports.on = (key, callback) -> route[key] = callback

exports.connect = (domain, port) ->
  # domain = domain[...-1] while domain[-1..] is "/"
  if not port?
    port = Number domain
    domain = location.hostname
  socket = new WebSocket "ws://#{domain}:#{port}"

  exports.emit = (key, value) ->
    socket.send JSON.stringify {key, value}

  socket.onmessage = (event) ->
    data = JSON.parse event.data
    route[data.key]? data.value

  exports.onopen = (callback) ->
    socket.onopen = callback
  exports