class PassengersController < ActionController::Base
  def index
    @passengers = Passenger.all
  end
end