App.appraisal_message = App.cable.subscriptions.create {
    channel: "AppraisalMessageChannel"
    pathname: window.location.pathname
  },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#incomplete_tasks').append(data.message)
