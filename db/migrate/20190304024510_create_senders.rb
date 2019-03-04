class CreateSenders < ActiveRecord::Migration[5.2]
  def change
    create_table :senders do |t|
      t.string :name
      t.string :telephone
      t.string :email
      t.integer :status

      t.timestamps
    end
  end
end
