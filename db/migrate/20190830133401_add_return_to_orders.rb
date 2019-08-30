class AddReturnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :return, :boolean, default: false
  end
end
