class PassengersController < ActionController::Base
  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to index_path
    end  
  end

  private 

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end

end