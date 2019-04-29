class PostedOrderJob < ApplicationJob #ActiveJob::Base
  queue_as :default

  def perform(order_id)
  order = Order.find(order_id)

    if order.status == 'posted'  
      if order.radius < MAX_RADIUS
	      order.radius += DELTA_RADIUS
	      order.save	             
        PostedOrderJob.set(wait: 2.second).perform_later(order.id) # DELTA_TIME
      
     # # new from here to 
     # elsif order.status == 'taken'
     #   order.status = 'taken'        
     #   #order.radius = order.radius
     #   order.save
     #   #here 

      else #order.status = 'draft' 
        order.status = 'draft'         
        order.radius = 500
        order.save       
      end

      #  else order.status = 'draft' 
      #    order.status = 'draft'         
      #    order.radius = 500
      #    order.save	    
      #  end


    #elsif order.status = 'draft' 
    #    order.status = 'draft'        
    #    order.radius = 500
    #    order.save
    end
  end
end






#        puts ""
#        puts ""
#        puts "Count B= #{count}"
#        puts ""
#        puts ""#