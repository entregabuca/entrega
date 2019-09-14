# == Schema Information
#
# Table name: transporters
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  telephone              :string
#  email                  :string
#  status                 :integer
#  company_id             :bigint
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#

class Transporter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company
  has_many :orders, dependent: :destroy  # if dependent destroy isn't placed we aren't unable to destroy the Company
  
  before_create :default_status

  enum status:{
   "inactive" => 0,
   "active" => 1,
   "available" => 2,
   "busy" => 3,
   "offwork" => 4
  }
  
  def default_status
    self.status = "inactive"
  end



#  def status_active  # could be changed to order_posted
#    self.status == 'active'     
#  end
#
#  #EMAIL_REGEX = /\A[a-z0-9.%+-]+@[a-z09.-]+\.[a-z]{2,4}\Z/i
#  #t.integer "radius" Unsure if radius needs validation
#  with_options if: :status_active do |sender|
#    sender.validates :name, presence: true 
#    sender.validates :telephone, presence: true
#    sender.validates :email, presence: true
#    sender.validates :email, length: { maximum: 25}
#    #sender.validates :email, format: { :with => EMAIL_REGEX, message: "is not valid. Try again." }
#    #sender.validates :email, confirmation: true
#  end

end
