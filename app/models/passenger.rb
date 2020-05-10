class Passenger < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :phone_num, presence: true

  #Trips records are destroyed if Passenger's records are
  #I'm not sure this is the best way to do this because it then deletes the trip record for the driver -- maybe we add a column that is essentially "active" or "inactive". Records would be kept on file but not displayed.
  has_many :trips, dependent: :destroy
  
  def sum
    sum = self.trips.sum(:cost)
    return sum
  end
  
end
