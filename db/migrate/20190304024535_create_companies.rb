class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :telephone
      t.string :email
      t.integer :radius
      t.integer :status

      t.timestamps
    end
  end
end
