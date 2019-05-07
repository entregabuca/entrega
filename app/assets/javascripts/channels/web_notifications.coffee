if window.location.pathname.split('/')[1] == 'companies'
	App.cable.subscriptions.create "WebNotificationsChannel",
	  received: (data) ->
	    alert "Orden Lista para ser tomada"