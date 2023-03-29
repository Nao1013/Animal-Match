require "test_helper"

class Reader::AnimalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reader_animals_index_url
    assert_response :success
  end

  test "should get show" do
    get reader_animals_show_url
    assert_response :success
  end
end
