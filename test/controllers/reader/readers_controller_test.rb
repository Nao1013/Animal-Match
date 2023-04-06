require "test_helper"

class Reader::ReadersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get reader_readers_edit_url
    assert_response :success
  end

  test "should get show" do
    get reader_readers_show_url
    assert_response :success
  end
end
