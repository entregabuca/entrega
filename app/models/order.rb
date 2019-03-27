class Order < ApplicationRecord
  belongs_to :sender
  belongs_to :transporter, optional: true
  has_many :locations, as: :addressable
  has_many :order_statuses, dependent: :destroy

  accepts_nested_attributes_for :locations

  enum status:{
    "draft" => 0,
    "posted" => 1,
    "taken" => 2,
    "inTransit" => 3,
    "completed" => 4,
    "cancelled" => 5
  }
  # Sort orders by most recent first
  default_scope {order("created_at DESC")} 
 


end
