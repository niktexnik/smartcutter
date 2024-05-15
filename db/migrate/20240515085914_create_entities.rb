class CreateEntities < ActiveRecord::Migration[7.1]
  def change
    create_table :entities do |t|
      t.string :name
      t.integer :position
      t.string :state
      t.boolean :ready
      t.integer :pattern_id
      t.references :mediaset, null: false, foreign_key: true

      t.timestamps
    end
  end
end
