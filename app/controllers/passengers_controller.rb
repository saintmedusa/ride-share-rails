class PassengersController < ActionController::Base
  def home
  end 

  def index
    @passengers = Passenger.paginate(:page=>params[:page],:per_page=>15)
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to index_path
    end  
  end

  def new
    @passenger = Passenger.new
  end

  def edit
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      head :not_found
      return
    end  
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(passenger_params)
      redirect_to passenger_path 
      return
    else 
      render :new
      return
    end
  end

  private 

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end

end