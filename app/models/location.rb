class Location < ApplicationRecord
	belongs_to :addressable, polymorphic: true

	geocoded_by :address
  after_validation :geocode,  if: :address_changed?
end
