# == Schema Information
#
# Table name: order_statuses
#
#  id             :bigint           not null, primary key
#  status         :integer
#  status_time    :datetime
#  status_details :text
#  order_id       :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class OrderStatus < ApplicationRecord
  belongs_to :order

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
    "onWayPick" => 9,
    "refuse" => 10
  }
  
end
