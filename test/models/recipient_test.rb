# == Schema Information
#
# Table name: recipients
#
#  id         :bigint           not null, primary key
#  name       :string
#  telephone  :string
#  email      :string
#  order_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RecipientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
