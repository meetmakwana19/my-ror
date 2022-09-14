require 'test_helper'

class ExampleControllerTest < ActionDispatch::IntegrationTest
  test "should get action1" do
    get example_action1_url
    assert_response :success
  end

  test "should get action2" do
    get example_action2_url
    assert_response :success
  end

end
