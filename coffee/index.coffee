
{WS} = require './ws'

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

  socket.onopen = ->
    handle (new WS socket)