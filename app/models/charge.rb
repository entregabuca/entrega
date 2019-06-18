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
	