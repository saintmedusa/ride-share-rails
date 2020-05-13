require "test_helper"

describe PassengersController do
  before do
    Passenger.create(name: "Darkwing Duck", phone_num: "1-800-327-5946")
  end

  describe "index" do
    # Your tests go here
    it "should get index" do
      get "/passengers"
      must_respond_with :success
    end
  end

  describe "show" do
    # Your tests go here
    # get passenger_path(@passenger)
    # must_respond_with :success
    before do
      Passenger.create(name: "Lydia Deetz", phone_num: "333-3333")
    end

    it "will get show for valid ids" do
      # Arrange
      valid_passenger_id = Passenger.first.id
  
      # Act
      get "/passengers/#{valid_passenger_id}"
  
      # Assert
      must_respond_with :success
    end
  
    it "will respond with not_found for invalid ids" do
      # Arrange
      invalid_passenger_id = 999
  
      # Act
      get "/passengers/#{invalid_passenger_id}"
  
      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    # Your tests go here
    it "can get the new_passenger_path" do
      get new_passenger_path

      must_respond_with :success
    end

    it "can get the new_passenger_trip_path" do
      get new_passenger_trip_path(Passenger.first.id)

      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
    it "can create a new passenger" do

      # Arrange
      passenger_hash = {
        passenger: {
          name: "Carmen San Diego",
          phone_num: "111-1111"
        },
      }
      
      # Act-Assert
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1
      
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
  end

  describe "edit" do
    before do
      Passenger.create(name: "Badtz-Maru", phone_num: "543-6789")
    end
    # Your tests go here
    it "can get the edit page for an existing task" do
      # Your code here
      get edit_passenger_path(Passenger.first.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      # Your code here
      get edit_passenger_path(-1)
      
      # Assert
      must_respond_with 404
    end
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
    before do 
      Passenger.create(name: 'Daisy Fellowes', phone_num: '333-3333')
    end
    
    let(:passenger_hash){
      {passenger: {
        name: "Daisy Fellowes",
        phone_num: "333-3333"
        }
      }
    }
    it "can delete an existing task" do
      # Arrange      
      passenger = Passenger.first

      # Act-Assert
      expect {
        delete passenger_path(passenger.id), params: passenger_hash
      }.must_change "Passenger.count", 1
      
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end
end
