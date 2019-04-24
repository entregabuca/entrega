class Order < ApplicationRecord

 enum status:{
    "draft" => 0,
    "posted" => 1,
    "taken" => 2,
    "inTransit" => 3,
    "completed" => 4,
    "cancelled" => 5
  }

  belongs_to :sender
  belongs_to :transporter, optional: true
  has_many :locations, as: :addressable
  has_many :order_statuses, dependent: :destroy

  accepts_nested_attributes_for :locations, :allow_destroy => true, :reject_if => lambda { |a| a[:address].blank? }   # && a[:line2].blank? && a[:city].blank? && a[:zip].blank?

  # Sort orders by most recent first
  default_scope {order("created_at DESC")} 
  


  validate :pickup_time_cannot_be_in_the_past
  validate :delivery_time_is_a_minute_greater_than_now
  validate :delivery_time_must_greater_than_pickup_time
  #validate :pickup_time_cannot_be_greater_than_delivery_time


  # ----------------------------------- || -------------------------------------------------------------

# CHECK REFACTORING ON TIME LOGICS TO SEE WHAT CAN BE COMBINED OR ELIMINATED

# Code below avoids notifying user that has to set Pickup Time minimun in the present
# It seems that (current) should be used instead of (now) as per rails recomendations. 
# Check if needs change when deploying to production
# Also, it has been commented ou the delivery_time_cannot_be_in_the_past (else) if wanted/needed to put both in one method
  def pickup_time_cannot_be_in_the_past
    if ['draft', 'posted'].include?(self.status) 
      if pickup_time < DateTime.current
        self.pickup_time = DateTime.current
      #elsif delivery_time < DateTime.current
        #self.delivery_time = DateTime.current + 1.minutes  
      end
    end
  end


# Code below avoids notifying user that has to set Delivery Time has to be minimun 1 minute later in the present
  def delivery_time_is_a_minute_greater_than_now 
    if ['draft', 'posted'].include?(self.status)
      if delivery_time < DateTime.current
        self.delivery_time = DateTime.current + 1.minutes     
      end
    end
  end


# Specific Delivery Time could be added as a minimum time & NOT notify the user. Awaiting for business decisions
# Currently it notifies the user if delivery_time added is earlier thatn pickup time.
# Will need revision later depending on business logic when User may want to have things deliver by certain time 
# which will reduce/increase the cost of the service, needs double check
  def delivery_time_must_greater_than_pickup_time
    if ['posted'].include?(self.status)
      if delivery_time <= pickup_time
        errors.add(:delivery_time, 'MUST be later than Pickup Time ')    
      end
    end
  end


  # ----------------------------------- The Code encapsulated here works -------------------------------------------------------------
  
#  def order_posted 
#    self.status == 'posted'     
#  end
#
#  #validates :weight, numericality: { :greater_than_or_equal_to => 0.01 }
#
#  validates_associated :locations, if: :order_posted 
#
#
#  with_options if: :order_posted do |order|
#    order.validates :description, presence: true 
#    order.validates :weight, numericality: { :greater_than_or_equal_to => 1 }
#    order.validates :length, numericality: { :greater_than_or_equal_to => 1 }
#    order.validates :width, numericality: { :greater_than_or_equal_to => 1 } 
#    order.validates :heigth, numericality: { :greater_than_or_equal_to => 1 }
#    #validates_associated :address
#    #order.validates :locations, presence: true
#    order.validates :status, presence: true 
#    order.validates :cost, numericality: { :greater_than_or_equal_to => 1 }  
#    #order.validates :radius, presence: true, numericality: true 
#    order.validates :sender_id, presence: true  
#  end
# ----------------------------------- || -------------------------------------------------------------
  

#def posted_or_taken
#    count = 1
#    # In rality the radius below will be brought from the order with a value of 500 
#    #initial_radius = @order.radius

#    while @order.status == 'posted' && count < 4 # if after 40 secs order hasn't been 
#                              #taken bring it back to status Draft and its radius back to 500 
#      @order.radius = 500
#      n = 1        
#      while @order.status == 'posted' && count < 10 # Check for 10 secs otherwise extend radius
#        sleep 1     
#        n += 1
#      end

#      if @order.status == 'posted'
#        count += 1
#        @order.radius *= count
#      elsif @order.status == 'taken'
#        @order.radius *= count
#       # @order.radius.update
#      end

#      #@order.radius =500 This was commented as it didn't affect
#    end

#    if @order.status == 'taken'
#      # Print an alert??
#    else
#      @order.radius = 7356  # initial_radius
#      @order.status = 'draft'
#    end
#end

  
end
