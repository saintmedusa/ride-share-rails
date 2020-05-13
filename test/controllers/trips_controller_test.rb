require "test_helper"

describe TripsController do

  before do
    @passenger = Passenger.create(
      name: "Star Lord",
      phone_num: "555-5555"
    )

    @driver = Driver.create(
      name: "Groot",
      vin: "848485859"
    )

    @trip = Trip.create(
      date: "10-09-2019",
      rating: nil,
      cost: 2040,
      passenger_id: @passenger.id,
      driver_id: @driver.id
    )
  end

  describe "show" do
    # Your tests go here
      it "responds with success when showing an existing valid trip" do
        trip_id = @trip.id
  
        get trip_path(trip_id)
  
        must_respond_with :success
      end
  end

  describe "create" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
    it "loads the edit page for an existing trip" do
      get edit_trip_path(@trip.id)

      must_respond_with :success
    end

    it "responds with a redirect if attempting to edit a trip that does not exist" do
      get edit_trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "update" do
    # Your tests go here
    before do
      @updated_trip = {
        trip: {
          date: "05-09-2020",
          rating: 4,
          cost: 4340,
          passenger_id: @passenger.id,
          driver_id: @driver.id
        },
      }
    end

    it "can update an existing trip with valid information accurately, and redirect" do
      trip = Trip.create(
        date: "05-09-2020",
        rating: 5,
        cost: 4540,
        passenger_id: @passenger.id,
        driver_id: @driver.id
      )

      trip_id = trip.id

      expect {
        patch trip_path(trip_id), params: @updated_trip
      }.must_differ "Trip.count", 0

      expect(Trip.find_by(id: trip_id).rating).must_equal @updated_trip[:trip][:rating]
      expect(Trip.find_by(id: trip_id).cost).must_equal @updated_trip[:trip][:cost]
      must_respond_with :redirect
      must_redirect_to trip_path(trip_id)
    end

    it "does not update any trip if given an invalid id, and responds with a 404" do
      expect {
        patch trip_path(-1), params: @updated_trip
      }.must_differ "Trip.count", 0

      must_respond_with :not_found
    end

    it "does not update any trip if the form data violates Trip validations, and responds with a render of the edit page" do
      trip_id = @trip.id

      # If I was being good I would recreate an invalid trip for each required field
      invalid_trip = {
        trip: {
          date: "",
          rating: 4,
          cost: 4340,
          passenger_id: @passenger.id,
          driver_id: @driver.id
        },
      }

      expect {
        patch trip_path(trip_id), params: invalid_trip
      }.must_differ "Trip.count", 0

      must_respond_with :success
    end
  end

  describe "destroy" do
    # Your tests go here
    it "destroys the trip instance in the db and redirects" do
      trip = Trip.first
      trip_id = trip.id
      expect(Trip.count).must_be :>, 0

      expect {
        delete trip_path(trip_id)
      }.must_differ "Trip.count", -1

      assert_nil (Trip.find_by(id: trip_id))
      must_respond_with :redirect
      must_redirect_to passengers_path
    end 

    it "does not change the db when the trip does not exist and responds with a 404" do
      invalid_id = -1
      expect(Trip.count).must_be :>, 0
      assert_nil (Trip.find_by(id: invalid_id))

      expect {
        delete trip_path(invalid_id)
      }.must_differ "Trip.count", 0

      must_respond_with :not_found
    end


  end
end
