(document).on 'turbolinks:load', ->
App.cable.subscriptions.create 'NotificationChannel', received: (data) ->
  timeNotify = Date()
  alertify.notify timeNotify.substring(0, timeNotify.indexOf('GMT')) + "<br>" + #data.body, 'success', 20, ->
    console.log 'Notified'
    return


#$(document).on 'turbolinks:load', ->
#  channel = App.cable.subscriptions.create('NotificationChannel', received: (data) ->
#    timeNotify = undefined
#    timeNotify = Date()
#    alertify.notify timeNotify.substring(0, timeNotify.indexOf('GMT')) + '<br>' + data.body, 'success', 20, ->
#      console.log 'Notified'
#      return
#  )
#  return