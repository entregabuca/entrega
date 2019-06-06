$(document).on 'turbolinks:load', ->
	App.cable.subscriptions.create 'NotificationChannel', received: (data) ->
	  timeNotify = Date()
	  alertify.notify timeNotify.substring(0, timeNotify.indexOf('GMT')) + "<br>" + data.body, 'success', 20, ->
	    console.log 'Notified'
	    return