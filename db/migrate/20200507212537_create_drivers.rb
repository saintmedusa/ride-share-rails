class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      # t.integer :id
      t.string :name
      t.string :vin
      t.string :available

      t.timestamps
    end
  end
end
