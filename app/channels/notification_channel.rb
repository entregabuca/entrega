class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_company
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
