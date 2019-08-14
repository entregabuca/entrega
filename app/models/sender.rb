class Sender < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :locations, as: :addressable, :dependent => :destroy


  before_create :default_status

  enum status:{
    inactive:  0,
    active:  1
  }

  def status_active  # could be changed to order_posted
    self.status == 'active'     
  end
  
  def default_status
    self.status = "inactive"
  end

 # def location_validation
 #   if self.status == 'active'
 #     accepts_nested_attributes_for :locations, reject_if: :all_blank, allow_destroy: true
 #   end
 # end

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