class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  def self.new_trip(passenger)
    trip = Trip.create(
      driver_id: "1",
      passenger_id: passenger,
      date: DateTime.now.to_s,
      rating: nil,
      cost: "17"
    )
    return trip
  end

end
