require "test_helper"

class Facility::RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get facility_rooms_index_url
    assert_response :success
  end

  test "should get show" do
    get facility_rooms_show_url
    assert_response :success
  end
end
