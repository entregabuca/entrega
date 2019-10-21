class PostedOrderJob < ApplicationJob #ActiveJob::Base
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    puts""
    puts " ORDER STATUS = #{order.status}"
    puts""
      if ['posted', 'taken'].include?(order.status)          # , 'refuse' removed to check what happens// Other statuses has been allowed to be able to let the order #order.status == "posted" 
          if order.radius < MAX_RADIUS
    	      order.radius += DELTA_RADIUS
    	      order.save
            puts""
            puts "   RADIUS Order #{order.id} :: #{order.radius}"
            puts""
            PostedOrderNotificationJob.perform_later(order)  
            PostedOrderJob.set(wait: 15.second).perform_later(order.id) # DELTA_TIME
          else 
            order.status = "draft"         
            order.radius = 500
            order.save       
          end
      end
  end
end