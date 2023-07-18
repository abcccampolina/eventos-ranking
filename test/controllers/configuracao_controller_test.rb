require 'test_helper'

class ConfiguracaoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get configuracao_index_url
    assert_response :success
  end

end
