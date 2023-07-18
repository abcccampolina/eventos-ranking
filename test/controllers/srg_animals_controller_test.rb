require 'test_helper'

class SrgAnimalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get srg_animals_index_url
    assert_response :success
  end

end
