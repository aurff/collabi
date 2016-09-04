App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']").append("<div><strong>#{data.username}:</strong> #{data.body}</div>")
    # Called when there's incoming data on the websocket for this channel

  send_message: (chatroom_id, message) ->
    @perform "send_message", {chatroom_id: chatroom_id, body: message}
