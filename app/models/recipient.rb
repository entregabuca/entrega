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

class Recipient < ApplicationRecord
  belongs_to :order, optional: true
end
