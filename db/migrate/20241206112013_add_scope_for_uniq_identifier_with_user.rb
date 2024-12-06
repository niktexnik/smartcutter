class AddScopeForUniqIdentifierWithUser < ActiveRecord::Migration[7.1]
  def change
    remove_index :devices, :identifier
    add_index :devices, [:user_id, :platform, :identifier], unique: true, name: 'index_devices_on_user_id_and_platform'
  end
end
