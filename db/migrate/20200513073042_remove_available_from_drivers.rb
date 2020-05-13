class RemoveAvailableFromDrivers < ActiveRecord::Migration[6.0]
  def change
    remove_column :drivers, :available
  end
end
