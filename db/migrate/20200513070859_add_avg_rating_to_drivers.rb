class AddAvgRatingToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :avg_rating, :float
  end
end
