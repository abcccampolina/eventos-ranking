require 'test_helper'

class InscritosCompeticaoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get inscritos_competicao_index_url
    assert_response :success
  end

end
