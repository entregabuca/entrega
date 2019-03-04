class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.text :description
      t.decimal :weight
      t.decimal :length
      t.decimal :width
      t.decimal :heigth
      t.datetime :pickup_time
      t.datetime :delivery_time
      t.decimal :cost
      t.integer :status
      t.integer :radius
      t.belongs_to :sender, foreign_key: true
      t.belongs_to :transporter, foreign_key: true

      t.timestamps
    end
  end
end
