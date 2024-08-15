class CreateUsersEmailConfirmations < ActiveRecord::Migration[7.1]
  def change
    create_table :users_email_confirmations do |t|
      t.string :confirmation_token
      t.datetime :confirmation_token_expires_at
      t.references :user, null: false, foreign_key: true

      t.index :confirmation_token, unique: true

      t.timestamps
    end
  end
end
