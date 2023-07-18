require 'test_helper'

class SumulaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sumula_index_url
    assert_response :success
  end

end
