class CreateAssets < ActiveRecord::Migration[7.1]
  def change
    create_table :assets do |t|
      t.string :name
      t.string :type
      t.string :image
      t.string :position
      t.references :product, null: false, foreign_key: true
      t.references :entity, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
