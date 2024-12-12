class CreateProductsSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :products_settings do |t|
      t.integer :image_width, default: 1920
      t.integer :image_height, default: 1080
      t.integer :images_count, default: 3
      t.string :output_extension, default: 'png'
      t.string :pattern_ids, array: true, default: []
      t.boolean :tint_windows, default: false
      t.boolean :blure_plates, default: false
      t.boolean :add_shadows, default: false
      t.boolean :need_processing, default: true
      t.boolean :enabled, default: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
