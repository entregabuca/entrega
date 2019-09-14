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

require 'test_helper'

class TransporterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
