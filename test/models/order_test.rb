# == Schema Information
#
# Table name: orders
#
#  id                  :bigint           not null, primary key
#  description         :text
#  weight              :decimal(, )
#  length              :decimal(, )
#  width               :decimal(, )
#  heigth              :decimal(, )
#  pickup_time         :datetime
#  delivery_time       :datetime
#  cost                :decimal(, )
#  status              :integer
#  radius              :integer
#  sender_id           :bigint
#  transporter_id      :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  return              :boolean          default(FALSE)
#  company_earning     :decimal(, )
#  transporter_earning :decimal(, )
#  admin_earning       :decimal(, )
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
