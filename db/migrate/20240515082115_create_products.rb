class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :enabled, default: true
      t.integer :product_setting_id
      t.integer :pattern_id
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
