class TripsController < ApplicationController

  def show
    @trip = Trip.find(params[:id].to_i)

    if @trip.nil?
      render :notfound, status: :not_found    
    end  
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to trip_path
    else
      render :new
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
    end

    if @trip.update(trip_params)
      redirect_to @trip
    else
      render :edit
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
    return params.require(:trip).permit(:passenger_id, :date, :rating, :cost)
  end
end