class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :enabled, default: true
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
