class TripsController < ApplicationController

  def show
    @trip = Trip.find(params[:id].to_i)

    if @trip.nil?
      render :notfound, status: :not_found    
    end  
  end

  def new
    @trip = Trip.new
  end

  
  def create
    passenger = Passenger.find_by(id: params[:passenger_id])

    @trip = Trip.new
    @trip.passenger = passenger
    # @trip.driver = driver
    @trip.date = Date.today
    @trip.cost = rand(1000..3000)
    if @trip.save
      redirect_to trip_path
    else
      render :new
    end
  end
    # @trip = Trip.new_trip
    # passenger = Passenger.find_by(id: params[:passenger_id])
    # @trip = Trip.new_trip(passenger[:passenger_id])

    # if @trip.save
    #   redirect_to passenger_path
    # else
    #   render :error
    #   return
    # end
  #   if params[:passenger_id]
  #     passenger = Passenger.find_by(id: params[:passenger_id])
  #     @trip = passenger.trips.new
  #   else
  #     redirect_to passengers_path
  #   end
  # end

  def edit
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
      return
    end  
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to @trip 
      return
    else 
      render :edit
      return
    end
  end

  def destroy
    if @trip.nil?
      head :not_found
      return
    else  
      @trip = Trip.find(params[:id])
      @trip.destroy
    end
    redirect_to trips_path
    
  end

  private 

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end
end