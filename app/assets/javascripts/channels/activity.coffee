App.activity = App.cable.subscriptions.create "ActivityChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $.notify({},{
      placement: {
        from: "bottom",
        align: "left"
      },
      template: data.message
    })

  # Called when there's incoming data on the websocket for this channel
