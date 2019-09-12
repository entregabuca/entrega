class AddEarningColumnsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :company_earning, :decimal
    add_column :orders, :transporter_earning, :decimal
    add_column :orders, :admin_earning, :decimal
  end
end
