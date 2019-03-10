class Sender < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :locations, as: :addressable, :dependent => :destroy

  accepts_nested_attributes_for :locations, reject_if: :all_blank, allow_destroy: true

  enum status:{
    "inactive" => 0,
    "active" => 1
  }
end
