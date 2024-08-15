class CreateDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :devices do |t|
      t.string :fcm_token
      t.string :platform
      t.boolean :active, default: false
      t.string :app_version
      t.string :identifier
      t.datetime :confirmed_at
      t.references :user, null: false, foreign_key: true

      t.index :identifier, unique: true
      t.timestamps
    end
  end
end
