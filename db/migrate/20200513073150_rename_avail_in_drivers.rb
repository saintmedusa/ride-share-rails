class RenameAvailInDrivers < ActiveRecord::Migration[6.0]
  def change
    rename_column :drivers, :avail, :available
  end
end
