require 'test_helper'

class RelatorioControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get relatorio_index_url
    assert_response :success
  end

end
