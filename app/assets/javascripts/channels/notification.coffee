App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    
    # if NotificationChannel.permission == 'granted'
    
      title =  'Push notification'
      body = data
      options = {body: body}
      # NotificationChannel
      # Notification.new({title, options})
      new Notification(title, options)
    
    # Called when there's incoming data on the websocket for this channel
