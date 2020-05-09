class TripsController < ActionController::Base
  def index
    @trips = Trip.all
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
  
  def edit
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
      return
    end  
  end

  #FIX
  # def destroy
  #   trip_id = params[:id]
  #   @trip = Trip.find_by(id: trip_id)

  #   if @trip.nil?
  #     head :not_found
  #     return
  #   elsif 
  #     @trip.destroy
  #     redirect_to trip_path 
  #     return
  #   else 
  #     render @trip
  #     return
  #   end
  # end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to @trip
    else
      render :new, :bad_request
    end
  end

  private 

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end
end