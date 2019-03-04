class CreateTransporters < ActiveRecord::Migration[5.2]
  def change
    create_table :transporters do |t|
      t.string :name
      t.string :telephone
      t.string :email
      t.integer :status
      t.belongs_to :company, foreign_key: true

      t.timestamps
    end
  end
end
