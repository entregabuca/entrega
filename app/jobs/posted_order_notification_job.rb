class PostedOrderNotificationJob < ApplicationJob
  queue_as :default

  def perform(order)
    coordinates = [order.locations[0].latitude,order.locations[0].longitude]
    # OJO this need to be improved with geokit/coder
    companies_near = Company.active.select {|c| (Geocoder::Calculations.distance_between(coordinates, \
               c.locations[0].present? ? [c.locations[0].latitude,c.locations[0].longitude] : [0, 0])*1000) <= order.radius ? c : nil}

    companies_near.each do |company|
      puts "   Notification Sent to COMPANY #{company.id}"
      NotificationChannel.broadcast_to(company, title: "#{Order.human_attribute_name(:notification)}", body: "ORDER NO: #{order.id} #{Order.human_attribute_name(:order_ready)} ")
    end
  end
end