class OrderStatus < ApplicationRecord
  belongs_to :order

  enum status:{
    "draft" => 0,
    "posted" => 1,
    "taken" => 2,
    "inTransit" => 3,
    "completed" => 4,
    "cancelled" => 5,
    "payment" => 6
  }
end
