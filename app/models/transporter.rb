class Transporter < ApplicationRecord
  belongs_to :company
  has_many :orders, dependent: :destroy  # if dependent destroy isn't placed we aren't unable to destroy the Company

  enum status:{
    "inactive" => 0,
    "active" => 1
  }
end
