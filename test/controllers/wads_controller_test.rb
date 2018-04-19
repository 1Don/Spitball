require 'test_helper'

class WadsControllerTest < ActionDispatch::IntegrationTest
	test "should get new" do
		assert_not_nil(current_user)
		get wads_new_url
	end

end
