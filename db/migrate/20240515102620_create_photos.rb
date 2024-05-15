class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.references :entity, null: false, foreign_key: true
      t.references :mediaset, null: false, foreign_key: true
      t.string :photo
      t.integer :width
      t.integer :height
      t.integer :file_size
      t.timestamps
    end
  end
end
