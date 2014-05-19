
u =
  n: 0
  id: -> "b#{@n += 1}"

exports.WS = class
  constructor: (@_socket) ->
    @_routes = {}
    @_emitCalls = {}
    @_events = []
    @_closeCalls = []

    @closed = no

    @_listen()

  _send: (data) ->
    if @closed
      return console.log 'WS-JSON: aleady closed'
    @_socket.send (JSON.stringify data)

  on: (key, cb) ->
    @_routes[key] = cb

  emit: (key, value, cb) ->
    if typeof value is 'function'
      cb = value
      value = null
    id = u.id()
    @_send [key, value, id]
    @_emitCalls[id] = cb

  _listen: ->
    @_socket.onmessage = (message) =>
      @_handleMessage message

    @_socket.onclose = =>
      @_handleClose()

  _handleMessage: (message) ->
    [key, value, id] = JSON.parse message.data
    @_routes[key]? value, (ret) => @_send [key, ret, id]
    @_emitCalls[id]? value

  listenTo: (source, message, cb) ->
    @_events.push [source, message, cb]
    source.on message, cb

  onclose: (cb) ->
    @_closeCalls.push cb

  _handleClose: ->
    @closed = yes
    cb() for cb in @_closeCalls

    for pair in @_events
      [source, message, cb] = pair
      source.removeListener message, cb

    @_socket = null
    @_routes = null
    @_emitCalls = null
    @_events = null
    @_closeCalls = null
