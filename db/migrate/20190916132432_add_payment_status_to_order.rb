class AddPaymentStatusToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment_status, :string
    add_index :orders, :payment_status
  end
end
