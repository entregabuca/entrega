class Company < ApplicationRecord
  has_many :transporters, dependent: :destroy
  has_many :orders, through: :transporters
  has_many :locations, as: :addressable

  accepts_nested_attributes_for :locations, reject_if: :all_blank, allow_destroy: true

  enum status:{
    "inactive" => 0,
    "active" => 1
  }

end
