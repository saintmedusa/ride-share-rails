class AddAvailToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :avail, :boolean, default: true
  end
end
