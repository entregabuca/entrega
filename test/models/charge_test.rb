# == Schema Information
#
# Table name: charges
#
#  id             :bigint           not null, primary key
#  uid            :string(50)
#  status         :integer          default("created")
#  payment_method :integer          default("unknown")
#  amount         :decimal(, )      default(0.0)
#  error_message  :text
#  response_data  :jsonb
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  order_id       :bigint
#

require 'test_helper'

class ChargeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
