class Sender < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :locations, as: :addressable

  enum status:{
    "inactive" => 0,
    "active" => 1
  }
end
