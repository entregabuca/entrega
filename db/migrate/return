class AddPayWithToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :pay_with, :string
    add_index :orders, :pay_with
  end
end
