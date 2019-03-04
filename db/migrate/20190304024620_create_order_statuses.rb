class CreateOrderStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :order_statuses do |t|
      t.integer :status
      t.timestamp :status_time
      t.text :status_details
      t.belongs_to :order, foreign_key: true

      t.timestamps
    end
  end
end
