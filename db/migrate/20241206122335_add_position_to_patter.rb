class AddPositionToPatter < ActiveRecord::Migration[7.1]
  def change
    add_column :patterns, :position, :integer
  end
end
