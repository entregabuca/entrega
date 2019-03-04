class Transporter < ApplicationRecord
  belongs_to :company
  has_many :orders

  enum status:{
    "inactive" => 0,
    "active" => 1
  }
end
