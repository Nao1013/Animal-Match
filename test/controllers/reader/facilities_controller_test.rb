require "test_helper"

class Reader::FacilitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get reader_facilities_show_url
    assert_response :success
  end
end
