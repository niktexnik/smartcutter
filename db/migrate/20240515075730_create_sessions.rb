class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.string :ip
      t.string :access_token
      t.datetime :token_expire_at
      t.string :refresh_token
      t.datetime :refresh_token_expire_at
      t.references :device, null: false, foreign_key: true

      t.timestamps
    end
  end
end
