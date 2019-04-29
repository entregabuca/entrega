class Location < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  
  validates_presence_of :address
end
