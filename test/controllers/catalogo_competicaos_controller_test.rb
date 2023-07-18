require 'test_helper'

class CatalogoCompeticaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @catalogo_competicao = catalogo_competicaos(:one)
  end

  test "should get index" do
    get catalogo_competicaos_url
    assert_response :success
  end

  test "should get new" do
    get new_catalogo_competicao_url
    assert_response :success
  end

  test "should create catalogo_competicao" do
    assert_difference('CatalogoCompeticao.count') do
      post catalogo_competicaos_url, params: { catalogo_competicao: { competicaos_eventos: @catalogo_competicao.competicaos_eventos, qtd_catalogos: @catalogo_competicao.qtd_catalogos, qtd_inscritos: @catalogo_competicao.qtd_inscritos } }
    end

    assert_redirected_to catalogo_competicao_url(CatalogoCompeticao.last)
  end

  test "should show catalogo_competicao" do
    get catalogo_competicao_url(@catalogo_competicao)
    assert_response :success
  end

  test "should get edit" do
    get edit_catalogo_competicao_url(@catalogo_competicao)
    assert_response :success
  end

  test "should update catalogo_competicao" do
    patch catalogo_competicao_url(@catalogo_competicao), params: { catalogo_competicao: { competicaos_eventos: @catalogo_competicao.competicaos_eventos, qtd_catalogos: @catalogo_competicao.qtd_catalogos, qtd_inscritos: @catalogo_competicao.qtd_inscritos } }
    assert_redirected_to catalogo_competicao_url(@catalogo_competicao)
  end

  test "should destroy catalogo_competicao" do
    assert_difference('CatalogoCompeticao.count', -1) do
      delete catalogo_competicao_url(@catalogo_competicao)
    end

    assert_redirected_to catalogo_competicaos_url
  end
end
