App.cable.subscriptions.create "NotificationChannel",
	  received: (data) -> alert data.body