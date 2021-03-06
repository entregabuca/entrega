# == Schema Information
#
# Table name: companies
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  telephone              :string
#  email                  :string
#  radius                 :integer
#  status                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#

class Company < ApplicationRecord
  include InactiveStatus
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :transporters, dependent: :destroy
  has_many :orders, through: :transporters
  has_many :locations, as: :addressable, :dependent => :destroy
  
  accepts_nested_attributes_for :locations, reject_if: :all_blank, allow_destroy: true
  before_create :set_default_location
  before_create :inactive_status 


  enum status:{
    "inactive" => 0,
    "active" => 1
  }
 
  #def default_status
  #  self.status = 'inactive'
  #end

  def status_active  # could be changed to order_posted
    self.status == 'active'     
  end
# 


  def set_default_location
    if !locations.present?
      self.locations << Location.create( {latitude: 0 , longitude: 0})      
    end 
  end

 with_options if: :status_active do |company|
   company.validates :name, presence: true 
   company.validates :telephone, presence: true
   company.validates :email, presence: true
   company.validates :email, length: { maximum: 25}   
   #company.validates :email, confirmation: true
 end

EMAIL_REGEX = /\A[a-z0-9.%+-]+@[a-z09.-]+\.[a-z]{2,4}\Z/i
validates :email, format: { with: EMAIL_REGEX, message: :invalid_format} 

end
