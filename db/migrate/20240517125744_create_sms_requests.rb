class CreateSmsRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :sms_requests do |t|
      t.string :phone
      t.string :state
      t.inet :ip

      t.timestamps
    end
  end
end
