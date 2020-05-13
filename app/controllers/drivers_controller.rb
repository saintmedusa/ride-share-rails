class DriversController < ApplicationController
  def index
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      head :not_found
      return
    end
  end


  def new
  end
  def edit
  end
end
