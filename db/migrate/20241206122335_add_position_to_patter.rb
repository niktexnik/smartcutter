class AddPositionToPatter < ActiveRecord::Migration[7.1]
  def change
    add_column :patterns, :position, :integer
    add_column :photos, :step, :string
  end
end
