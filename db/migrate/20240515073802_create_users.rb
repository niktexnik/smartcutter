class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :email
      t.boolean :agreement, default: false
      t.boolean :email_confirmed, default: false
      t.string :phone
      t.integer :company_id
      t.string :password_digest
      t.timestamps

      t.index :email, unique: true
      t.index :phone, unique: true
    end
  end
end
