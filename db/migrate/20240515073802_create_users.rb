class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :middlename
      t.string :email
      t.boolean :agreement, default: false
      t.string :phone
      t.integer :company_id

      t.timestamps
    end
  end
end
