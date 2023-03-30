require "test_helper"

class Facility::FacilitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get facility_facilities_show_url
    assert_response :success
  end

  test "should get index" do
    get facility_facilities_index_url
    assert_response :success
  end
end
