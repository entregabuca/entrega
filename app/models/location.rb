# == Schema Information
#
# Table name: locations
#
#  id               :bigint           not null, primary key
#  address          :string
#  latitude         :float
#  longitude        :float
#  addressable_type :string
#  addressable_id   :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Location < ApplicationRecord
  belongs_to :addressable, polymorphic: true


  validates_presence_of :address


  #validates_presence_of :address,
  #    :message => Proc.new { |location, data|
  #    "You must provide #{data[:attribute]} for "
  #    }

end
