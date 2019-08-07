$(document).on 'turbolinks:load', ->
  App.cable.subscriptions.subscriptions.forEach (element) ->
    console.log 'Unsubscribing from Connection started at: '.concat(element.consumer.connection.monitor.startedAt.toString())
    element.unsubscribe()
    return
  App.cable.subscriptions.create 'NotificationChannel', received: (data) ->
    timeNotify = undefined
    timeNotify = Date()
    alertify.notify timeNotify.substring(0, timeNotify.indexOf('GMT')) + '<br>' + data.body, 'success', 9, ->
      console.log 'Notified'
      return
  console.log 'Subscribed Connections: '.concat(App.cable.subscriptions.subscriptions.length.toString())
  return