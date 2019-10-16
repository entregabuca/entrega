# == Schema Information
#
# Table name: orders
#
#  id                  :bigint           not null, primary key
#  description         :text
#  weight              :decimal(, )
#  length              :decimal(, )
#  width               :decimal(, )
#  heigth              :decimal(, )
#  pickup_time         :datetime
#  delivery_time       :datetime
#  cost                :decimal(, )
#  status              :integer
#  radius              :integer
#  sender_id           :bigint
#  transporter_id      :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  return              :boolean          default(FALSE)
#  company_earning     :decimal(, )
#  transporter_earning :decimal(, )
#  admin_earning       :decimal(, )
#  pay_with            :string
#  payment_status      :string
#

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
    "payment" => 6,
    "pickArrived" => 7,
    "deliverArrived" => 8,
    "onWayPick" => 9
  }

  enum pay_with:{ cash: "cash", card: "card" }
  enum payment_status:{ paid: "paid", unpaid: "unpaid" }


  validates :description, presence: true 
  after_save :check_status_is_posted 
  after_save :notify_transporter_of_new_order
  after_save :notify_sender_and_company_transporter_is_on_the_way_to_pick_up_address
  after_save :notify_sender_transporter_is_at_sending_point
  after_save :notify_sender_transporter_is_at_delivery_point

  has_one :charge
  belongs_to :sender
  belongs_to :transporter, optional: true
  has_many :locations, as: :addressable
  has_many :comments, as: :commentable
  has_many :order_statuses, dependent: :destroy
  has_many :recipients, dependent: :destroy
  
  accepts_nested_attributes_for :locations, allow_destroy: true # :reject_if => lambda { |a| a[:address].blank? }   # && a[:line2].blank? && a[:city].blank? && a[:zip].blank?
  accepts_nested_attributes_for :comments, allow_destroy: true
  accepts_nested_attributes_for :recipients, :allow_destroy => true
  accepts_nested_attributes_for :order_statuses, :allow_destroy => true

  # Sort orders by most recent first
  default_scope {order("created_at DESC")} 

  validate :status_draft_radius_500


  validate :set_earnings
  
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


def notify_transporter_of_new_order
  if status == 'taken'
    puts " Notification Sent to TRANSPORTER #{transporter.id}"
    NotificationChannel.broadcast_to(transporter, title: "#{Order.human_attribute_name(:new_order)}", body: "#{Order.human_attribute_name(:new_order_assigned)}")
  end
end

def notify_sender_and_company_transporter_is_on_the_way_to_pick_up_address 
  if status == 'onWayPick'
    puts " Notification Sent to SENDER #{sender.id} and to company #{transporter.company.id}"
    NotificationChannel.broadcast_to(sender, title: "#{Order.human_attribute_name(:accept_order)}", body: "#{Order.human_attribute_name(:on_the_way_pick)}")
    NotificationChannel.broadcast_to(transporter.company, title: "#{Order.human_attribute_name(:accept_order)}", body: "#{Order.human_attribute_name(:on_the_way_pick)}")
  end
end

def notify_sender_transporter_is_at_sending_point
  if status == 'pickArrived'
    puts " Notification Sent to SENDER #{sender.id}"
    NotificationChannel.broadcast_to(sender, title: "#{Order.human_attribute_name(:at_pick_location)}", body: "#{Order.human_attribute_name(:transporter_at_pick_location)}")
  end    
end

def notify_sender_transporter_is_at_delivery_point
  if status == 'deliverArrived'
    puts " Notification Sent to SENDER #{sender.id}"
    NotificationChannel.broadcast_to(sender, title: "#{Order.human_attribute_name(:at_delivery_location)}", body: "#{Order.human_attribute_name(:transporter_at_delivery_location)}")
  end    
end





  def set_earnings
    if self.status == 'posted'
      self.company_earning = cost * 0.3
      self.transporter_earning = cost * 0.6
      self.admin_earning = cost * 0.1
    end
  end
end