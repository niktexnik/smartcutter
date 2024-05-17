class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :middle_name
      t.string :email
      t.boolean :agreement, default: false
      t.string :phone
      t.integer :company_id
      t.integer :count_of_failure_sms_confirmation, default: 0
      t.timestamps
    end
  end
end
