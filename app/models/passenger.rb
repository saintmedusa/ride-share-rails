class Passenger < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :phone_num, presence: true

  has_many :trips, dependent: :destroy
  
  def sum
    sum = self.trips.sum(:cost)
    return sum
  end
  
end
