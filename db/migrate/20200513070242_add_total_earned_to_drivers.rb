class AddTotalEarnedToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :total_earned, :integer
  end
end
