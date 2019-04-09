require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get geocode" do
    get locations_geocode_url
    assert_response :success
  end

end
