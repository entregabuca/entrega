class PostedOrderNotificationJob < ApplicationJob
  queue_as :default

  def perform(order)
  	coordinates = [order.locations[0].latitude,order.locations[0].longitude]
  	companies_near = Company.all.select {|c| (Geocoder::Calculations.distance_between(coordinates, \
                [c.locations[0].latitude,c.locations[0].longitude])*1000) <= order.radius ? c : nil}

  	companies_near.each do |company|
  		puts "   Notification Sent to Company #{company.id}"
  		NotificationChannel.broadcast_to(company, title: "#{Order.human_attribute_name(:notification)}", body: "#{Order.human_attribute_name(:order_ready)}")
  	end
  end
end
