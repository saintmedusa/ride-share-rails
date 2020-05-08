class Passenger < ApplicationRecord
  has_many :trips
  
  def sum
    sum = self.trips.sum(:cost)
    return sum
  end
  
end
