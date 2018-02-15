require 'test_helper'

class WadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wads_index_url
    assert_response :success
  end

  test "should get new" do
    get wads_new_url
    assert_response :success
  end

end
