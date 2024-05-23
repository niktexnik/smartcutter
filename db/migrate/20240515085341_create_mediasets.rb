class CreateMediasets < ActiveRecord::Migration[7.1]
  def change
    create_table :mediasets do |t|
      t.string :name
      t.string :state
      t.boolean :ready, default: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
