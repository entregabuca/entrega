# == Schema Information
#
# Table name: senders
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  telephone              :string
#  email                  :string
#  status                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#

class Sender < ApplicationRecord
  include InactiveStatus
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :locations, as: :addressable, :dependent => :destroy
  
  accepts_nested_attributes_for :locations, allow_destroy: true

  before_create :set_default_location
  before_create :inactive_status 

  enum status:{
    inactive:  0,
    active:  1
  }

  def status_active  # could be changed to order_posted
    self.status == 'active'     
  end
  
  def default_status
    self.status = "inactive"
  end

  def set_default_location
    if !locations.present?
      self.locations << Location.create( {latitude: 0 , longitude: 0})      
    end 
  end

 with_options if: :status_active do |sender|
   sender.validates :name, presence: true 
   sender.validates :telephone, presence: true
   sender.validates :email, presence: true
   sender.validates :email, length: { maximum: 25}
   #sender.validates :status, default: "active"
#   #sender.validates :email, confirmation: true
 end

EMAIL_REGEX = /\A[a-z0-9.%+-]+@[a-z09.-]+\.[a-z]{2,4}\Z/i
validates :email, format: { with: EMAIL_REGEX, message: :invalid_format} 

end
