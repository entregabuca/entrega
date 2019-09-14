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

class Charge < ApplicationRecord

enum status: [:created, :pending, :paid, :rejected, :error]
enum payment_method: [:unknown, :credit_card, :debit_card, :pse, :cash, :referenced]

belongs_to :order, optional: true
before_create :genereate_uid

private

	def genereate_uid
		begin
			self.uid = SecureRandom.hex(5)
		end while self.class.exists?(uid: self.uid)
	end
	
end
	
