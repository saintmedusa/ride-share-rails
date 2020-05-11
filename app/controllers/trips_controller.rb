class TripsController < ApplicationController
  # def index
  #   if params[:author_id]
  #     # This is the nested route, /author/:author_id/books
  #     passenger = Passenger.find_by(id: params[:passenger_id])
  #     @trips = passenger.trips

  #   else
  #     # This is the 'regular' route, /books
  #     @trips = Trip.all
  #   end
  # end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to passenger_path
    end  
  end

  # def new
  #   if params[:passenger_id].nil?
  #     @trip = Trip.new
  #   else
  #     passenger = Passenger.find_by(id: params[:passenger_id])
  #     @trip = passenger.trips.new
  #   end
  # end

  def create
    # @trip = Trip.new_trip
    # passenger = Passenger.find_by(id: params[:passenger_id])
    # @trip = Trip.new_trip(passenger[:passenger_id])

    # if @trip.save
    #   redirect_to passenger_path
    # else
    #   render :error
    #   return
    # end
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = passenger.trips.new
    else
      Trip.new_trip(params[:passenger_id])
      redirect_to passenger_path
    end
  end

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
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
      return
    end

    @trip.destroy
    redirect_to passengers_path
    
  end

  private 

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end
end