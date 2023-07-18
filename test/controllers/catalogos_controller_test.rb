require 'test_helper'

class CatalogosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @catalogo = catalogos(:one)
  end

  test "should get index" do
    get catalogos_url
    assert_response :success
  end

  test "should get new" do
    get new_catalogo_url
    assert_response :success
  end

  test "should create catalogo" do
    assert_difference('Catalogo.count') do
      post catalogos_url, params: { catalogo: { competicao_evento_id: @catalogo.competicao_evento_id, inscricaos_id: @catalogo.inscricaos_id, nome_catalogo: @catalogo.nome_catalogo } }
    end

    assert_redirected_to catalogo_url(Catalogo.last)
  end

  test "should show catalogo" do
    get catalogo_url(@catalogo)
    assert_response :success
  end

  test "should get edit" do
    get edit_catalogo_url(@catalogo)
    assert_response :success
  end

  test "should update catalogo" do
    patch catalogo_url(@catalogo), params: { catalogo: { competicao_evento_id: @catalogo.competicao_evento_id, inscricaos_id: @catalogo.inscricaos_id, nome_catalogo: @catalogo.nome_catalogo } }
    assert_redirected_to catalogo_url(@catalogo)
  end

  test "should destroy catalogo" do
    assert_difference('Catalogo.count', -1) do
      delete catalogo_url(@catalogo)
    end

    assert_redirected_to catalogos_url
  end
end
