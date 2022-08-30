require "test_helper"

class CircleRecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get circle_recipes_new_url
    assert_response :success
  end

  test "should get create" do
    get circle_recipes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get circle_recipes_destroy_url
    assert_response :success
  end
end
