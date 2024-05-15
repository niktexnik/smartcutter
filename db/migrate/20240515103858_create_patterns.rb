class CreatePatterns < ActiveRecord::Migration[7.1]
  def change
    create_table :patterns do |t|
      t.string :name
      t.string :type
      t.string :image
      t.integer :road_height
      t.references :product, null: false, foreign_key: true
      t.references :entity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
