require 'test_helper'

class ParametroInscricaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parametro_inscricao = parametro_inscricaos(:one)
  end

  test "should get index" do
    get parametro_inscricaos_url
    assert_response :success
  end

  test "should get new" do
    get new_parametro_inscricao_url
    assert_response :success
  end

  test "should create parametro_inscricao" do
    assert_difference('ParametroInscricao.count') do
      post parametro_inscricaos_url, params: { parametro_inscricao: { coluna_parametro: @parametro_inscricao.coluna_parametro, competicao_id: @parametro_inscricao.competicao_id, nome: @parametro_inscricao.nome, operador_parametro: @parametro_inscricao.operador_parametro, valor_parametro: @parametro_inscricao.valor_parametro } }
    end

    assert_redirected_to parametro_inscricao_url(ParametroInscricao.last)
  end

  test "should show parametro_inscricao" do
    get parametro_inscricao_url(@parametro_inscricao)
    assert_response :success
  end

  test "should get edit" do
    get edit_parametro_inscricao_url(@parametro_inscricao)
    assert_response :success
  end

  test "should update parametro_inscricao" do
    patch parametro_inscricao_url(@parametro_inscricao), params: { parametro_inscricao: { coluna_parametro: @parametro_inscricao.coluna_parametro, competicao_id: @parametro_inscricao.competicao_id, nome: @parametro_inscricao.nome, operador_parametro: @parametro_inscricao.operador_parametro, valor_parametro: @parametro_inscricao.valor_parametro } }
    assert_redirected_to parametro_inscricao_url(@parametro_inscricao)
  end

  test "should destroy parametro_inscricao" do
    assert_difference('ParametroInscricao.count', -1) do
      delete parametro_inscricao_url(@parametro_inscricao)
    end

    assert_redirected_to parametro_inscricaos_url
  end
end
