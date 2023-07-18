require 'test_helper'

class CriteriosAvaliacaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @criterios_avaliacao = criterios_avaliacaos(:one)
  end

  test "should get index" do
    get criterios_avaliacaos_url
    assert_response :success
  end

  test "should get new" do
    get new_criterios_avaliacao_url
    assert_response :success
  end

  test "should create criterios_avaliacao" do
    assert_difference('CriteriosAvaliacao.count') do
      post criterios_avaliacaos_url, params: { criterios_avaliacao: { cluster_criterios_avaliacao_id: @criterios_avaliacao.cluster_criterios_avaliacao_id, metodo: @criterios_avaliacao.metodo, nome: @criterios_avaliacao.nome, peso: @criterios_avaliacao.peso } }
    end

    assert_redirected_to criterios_avaliacao_url(CriteriosAvaliacao.last)
  end

  test "should show criterios_avaliacao" do
    get criterios_avaliacao_url(@criterios_avaliacao)
    assert_response :success
  end

  test "should get edit" do
    get edit_criterios_avaliacao_url(@criterios_avaliacao)
    assert_response :success
  end

  test "should update criterios_avaliacao" do
    patch criterios_avaliacao_url(@criterios_avaliacao), params: { criterios_avaliacao: { cluster_criterios_avaliacao_id: @criterios_avaliacao.cluster_criterios_avaliacao_id, metodo: @criterios_avaliacao.metodo, nome: @criterios_avaliacao.nome, peso: @criterios_avaliacao.peso } }
    assert_redirected_to criterios_avaliacao_url(@criterios_avaliacao)
  end

  test "should destroy criterios_avaliacao" do
    assert_difference('CriteriosAvaliacao.count', -1) do
      delete criterios_avaliacao_url(@criterios_avaliacao)
    end

    assert_redirected_to criterios_avaliacaos_url
  end
end
