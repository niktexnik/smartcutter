class CreateUsersResetPasswordConfirmations < ActiveRecord::Migration[7.1]
  def change
    create_table :users_reset_password_confirmations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reset_token
      t.datetime :reset_token_expires_at

      t.index :reset_token, unique: true
      t.timestamps
    end
  end
end
