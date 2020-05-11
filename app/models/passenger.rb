class Passenger < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :phone_num, presence: true

  #I originally had it so that trip records are destroyed if passenger's records are
  #I'm not sure this is the best way to do this because it then deletes the trip record for the driver -- maybe we add a column that is essentially "active" or "inactive". Records would be kept on file but not displayed.
  has_many :trips
  
  def sum
    sum = self.trips.sum(:cost)
    return sum
  end
  
end
