require "test_helper"

class Facility::AnimalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get facility_animals_index_url
    assert_response :success
  end

  test "should get show" do
    get facility_animals_show_url
    assert_response :success
  end

  test "should get new" do
    get facility_animals_new_url
    assert_response :success
  end
end
