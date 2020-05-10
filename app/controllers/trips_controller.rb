class TripsController < ApplicationController
  def index
    if params[:author_id]
      # This is the nested route, /author/:author_id/books
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips

    else
      # This is the 'regular' route, /books
      @trips = Trip.all
    end
  end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to index_path
    end  
  end

  def new
    if params[:passenger_id]
      # This is the nested route, /author/:author_id/books/new
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = passenger.trips.new
    else
      # This is the 'regular' route, /books/new
      @trip = Trip.new
    end
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to passenger_path
    else
      render :new, status: :bad_request
      return
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
      redirect_to trip_path 
      return
    else 
      render :edit
      return
    end
  end


  private 

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end
end