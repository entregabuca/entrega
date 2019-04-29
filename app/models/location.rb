class Location < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  
end
