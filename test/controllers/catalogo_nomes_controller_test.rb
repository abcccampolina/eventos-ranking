require 'test_helper'

class CatalogoNomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @catalogo_nome = catalogo_nomes(:one)
  end

  test "should get index" do
    get catalogo_nomes_url
    assert_response :success
  end

  test "should get new" do
    get new_catalogo_nome_url
    assert_response :success
  end

  test "should create catalogo_nome" do
    assert_difference('CatalogoNome.count') do
      post catalogo_nomes_url, params: { catalogo_nome: { competicaos_eventos_id: @catalogo_nome.competicaos_eventos_id, nome: @catalogo_nome.nome, ordem_nome: @catalogo_nome.ordem_nome } }
    end

    assert_redirected_to catalogo_nome_url(CatalogoNome.last)
  end

  test "should show catalogo_nome" do
    get catalogo_nome_url(@catalogo_nome)
    assert_response :success
  end

  test "should get edit" do
    get edit_catalogo_nome_url(@catalogo_nome)
    assert_response :success
  end

  test "should update catalogo_nome" do
    patch catalogo_nome_url(@catalogo_nome), params: { catalogo_nome: { competicaos_eventos_id: @catalogo_nome.competicaos_eventos_id, nome: @catalogo_nome.nome, ordem_nome: @catalogo_nome.ordem_nome } }
    assert_redirected_to catalogo_nome_url(@catalogo_nome)
  end

  test "should destroy catalogo_nome" do
    assert_difference('CatalogoNome.count', -1) do
      delete catalogo_nome_url(@catalogo_nome)
    end

    assert_redirected_to catalogo_nomes_url
  end
end
