App.appearance = App.cable.subscriptions.create "AppearanceChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    user = $(".user-#{data['user_id']}")
    user.toggleClass 'online', data['online']