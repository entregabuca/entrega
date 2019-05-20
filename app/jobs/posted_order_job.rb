class PostedOrderJob < ApplicationJob #ActiveJob::Base
  queue_as :default

  def perform(order_id)
  order = Order.find(order_id)

    if order.status == 'posted'  
      if order.radius < MAX_RADIUS
	      order.radius += DELTA_RADIUS
	      order.save

        puts "   RADIUS Order #{order.id} :: #{order.radius}"

        PostedOrderNotificationJob.perform_later(order)  
        PostedOrderJob.set(wait: 10.second).perform_later(order.id) # DELTA_TIME
      else 
        order.status = 'draft'         
        order.radius = 500
        order.save       
      end
    end
  end
end