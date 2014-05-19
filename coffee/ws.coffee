
exports.WS = class
  constructor: (@_socket) ->
    @_routes = {}
    @_emitCalls = {}
    @_affairs = []
    @_closeCalls = []

    @closed = no

    @_listen()

  _send: (data) ->
    if @closed
      return console.log 'WS-JSON: aleady closed'
    @_socket.send (JSON.stringify data)

  on: (key, callback) ->
    @_routes[key] = callback

  emit: (key, value, callback) ->
    if typeof value is 'function'
      callback = value
      value = null
    id = u.id()
    @_send [key, value, id]
    @_emitCalls[id] = callback

  _listen: ->
    @_socket.onmessage = (message) =>
      @_handleMessage message

  _handleMessage: (message) ->
    [key, value, id] = JSON.parse message.data
    routes[key]? value, (ret) -> send [key, ret, id]
    emitCalls[id]? value

  listenTo: (source, affair, callback) ->
    @_affairs.push {source, affair, callback}
    source.on affair, callback

  onclose: (cb) ->
    closeCalls.push cb

  onclose: ->
    @closed = yes
    cb() for cb in @_closeCalls

    for pair in @_affairs
      {source, affair, callback} = pair
      source.removeListener affair, callback

    @_socket = null
    @_routes = null
    @_emitCalls = null
    @_affairs = null

