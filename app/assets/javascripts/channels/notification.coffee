App.cable.subscriptions.create 'NotificationChannel', received: (data) ->
  timeNotify = Date()
  alertify.notify timeNotify.substring(0, timeNotify.indexOf('GMT')) + "<br>" + data.body, 'success', 10, ->
    console.log 'Notified'
    return