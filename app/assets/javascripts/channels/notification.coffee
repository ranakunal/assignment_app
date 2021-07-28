App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # if(NotificationChannel.permission === 'granted'){
    #   var title =  'Push notification'
    #   var body = 'Triggerd the notification'
    #   var options = {body: body}
    #   new NotificationChannel(title, options)
    # }
    # Called when there's incoming data on the websocket for this channel
