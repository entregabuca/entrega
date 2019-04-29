   order = Order.find(order_id)
   puts ""
   puts " INTRODUCTION "  	
   puts ""
   puts ""
   puts " Oreder ID is: #{order_id}"
   puts " Something is happening"
   sleep 1 
   puts " It will work"

    status = order.status
    puts " Status changed to is: #{status}"
  	radius = order.radius 
  	
    
    ## In reality the radius below will be brought from the order with a value of 500 
    initial_radius = radius
    puts " Initial Radius was: #{initial_radius}"
	puts ""
	puts ""








    count = 1

    while status == 'posted' && count < 15 # if after 15 secs order hasn't been taken bring it back to status Draft and its radius back to 500 
	    order.radius = 500
	    radius = order.radius 

	    #n = 1        
	    #while status == 'posted' && n < 5 # Check for 5 secs otherwise extend radius
	    #  sleep 1     
	    #  n += 1
	    #end
	    puts " Initial Count was: #{count}"
	    sleep 1
	    count += 1 
	    puts " Count is now: #{count}"
	    puts ""
	    puts ""
	    radius *= count
	    puts " Radius * Count is: #{radius}"
	    puts ""
	    puts ""
 
	end


















#-------------||---------------------
#  Some code that-- WORKS FINE
 	
#    order = Order.find(order_id)
#    puts ""
#    puts ""  	
#  	sleep 3
#  	puts ""
#	puts ""
#	puts " Oreder ID is: #{order_id}"
#  	puts " Something is happening"
#  	sleep 2 
#   	puts " It will work"
#
#    status = order.status
#    puts " Status is: #{status}"
#  	radius = order.radius 
#  	#puts " Radius was: #{radius}"
#
#    
#    ## In reality the radius below will be brought from the order with a value of 500 
#    initial_radius = radius
#    puts " Initial Radius was: #{initial_radius}"
#	puts ""
#	puts ""
#
##    count = 1
##
##    while status == 'posted' && count < 3 # if after 15 secs order hasn't been taken bring it back to status Draft and its radius back to 500 
##	    #order.radius = 500
##
##	    n = 1        
##	    while status == 'posted' && n < 5 # Check for 5 secs otherwise extend radius
##	      sleep 1     
##	      n += 1
##	    end
##	    if status == 'posted'
##	      count += 1
##	      radius *= count
##	      #update_column(:radius, radius)
##	    elsif status == 'taken'
##	      radius *= count
##	     # order.radius.update
##	    end
##	    #order.radius =500 This was commented as it didn't affect
##	  end
##
##
##  if status == 'taken'
##    # Print an alert??
##  else
##    radius = initial_radius
##    status = 'draft'
##  end
#
#
#    if status == 'posted'
#     sleep 4
#     radius = 1000
#     order.save
#    elsif status == 'taken'
#     sleep 4
#     radius = 1500
#     order.save
#    elsif status == 'draft'
#     sleep 
#     radius = 500
#     order.save
#   end
#   
#    puts ""
#	puts ""
#    status = order.status
#    puts " New Status is: #{status}"
#  	radius = order.radius 
#  	puts " New Radius is: #{radius}"
#  	puts ""
#	puts ""
#  
# end








#-------------||---------------------
#  code A -- WORKS FINE
#def perform(*args)
#   # Do something later
#   sleep 3
#   puts " Something is happening"
#   sleep 2 
#   puts " It will work"  
# end

#-------------||---------------------
#  code B -- WORKS FINE

#def perform(order_id, status)
#	
#   order = Order.find(order_id)
# 	puts "Oreder ID is: #{order_id}"
# 	sleep 3
# 	puts " Something is happening"
# 	sleep 2 
# 	puts " It will work"


# 	if order.status == 'posted'
#     sleep 2
#     order.radius = 1000
#     order.save

# 	elsif order.status == 'taken'
#     sleep 2
#     order.radius = 1500
#     order.save

#   elsif order.status == 'draft'
#     sleep 2
#     order.radius = 500
#     order.save
#   end
# 
#end


#-------------||---------------------
# Works sort of okay
#n = 0
#
#	if status == 'draft'
#      sleep 8
#      order.radius = 500
#      order.save
# 	elsif status == 'posted' #&& n < 10
# 	  puts " N starts at: #{n}" 
# 	  while order.status == 'posted'
# 	  	n += 1 	  	
#        sleep 1
#        puts " N is now: #{n}"
#      
#        order.radius = 1500 
#        puts ""
#	    puts ""
#	    puts " N incremented to: #{n}" 
#        puts " New radius is : #{order.radius}"
#        puts ""
#		puts ""       
#        order.save
#        break if order.status == 'draft' #|| n == 3
#      end 
#    elsif  status == 'taken'
#      sleep 5
#      order.radius = 4500
#      order.save
#   end#




