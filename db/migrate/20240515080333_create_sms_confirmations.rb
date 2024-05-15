class CreateSmsConfirmations < ActiveRecord::Migration[7.1]
  def change
    create_table :sms_confirmations do |t|
      t.string :state
      t.datetime :confirmed_at
      t.integer :count_failure_input
      t.integer :code
      t.references :device, null: false, foreign_key: true

      t.timestamps
    end
  end
end
