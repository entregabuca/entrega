class Order < ApplicationRecord

include ActiveModel::Dirty

#define_attribute_methods :status

  enum status:{
    "draft" => 0,
    "posted" => 1,
    "taken" => 2,
    "inTransit" => 3,
    "completed" => 4,
    "cancelled" => 5,
    "payment" => 6
  }

  after_save :check_status_is_posted



  has_one :charge
  belongs_to :sender
  belongs_to :transporter, optional: true
  has_many :locations, as: :addressable
  has_many :order_statuses, dependent: :destroy
  has_many :recipients, dependent: :destroy
  
  accepts_nested_attributes_for :locations, :allow_destroy => true, :reject_if => lambda { |a| a[:address].blank? }   # && a[:line2].blank? && a[:city].blank? && a[:zip].blank?
  accepts_nested_attributes_for :recipients, :allow_destroy => true
  # Sort orders by most recent first
  default_scope {order("created_at DESC")} 
  
  validate :pickup_time_cannot_be_in_the_past
  validate :delivery_time_is_a_minute_greater_than_now
  validate :delivery_time_must_greater_than_pickup_time
  #validate :pickup_time_cannot_be_greater_than_delivery_time
  validate :status_draft_radius_500
 #validate :status_posted_radius_500, on: :create

  def status_draft_radius_500
    if status == 'draft'
      self.radius = 500      
    end
  end


  def check_status_is_posted
    if self.saved_change_to_status? && status == 'posted'
      puts "POSTED JOB STARTED "
      PostedOrderJob.perform_later(self.id)
    end
  end

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
end
