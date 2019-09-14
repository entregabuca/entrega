# == Schema Information
#
# Table name: order_statuses
#
#  id             :bigint           not null, primary key
#  status         :integer
#  status_time    :datetime
#  status_details :text
#  order_id       :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class OrderStatusTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
