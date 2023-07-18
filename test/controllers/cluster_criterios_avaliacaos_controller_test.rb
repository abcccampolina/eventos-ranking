require 'test_helper'

class ClusterCriteriosAvaliacaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cluster_criterios_avaliacao = cluster_criterios_avaliacaos(:one)
  end

  test "should get index" do
    get cluster_criterios_avaliacaos_url
    assert_response :success
  end

  test "should get new" do
    get new_cluster_criterios_avaliacao_url
    assert_response :success
  end

  test "should create cluster_criterios_avaliacao" do
    assert_difference('ClusterCriteriosAvaliacao.count') do
      post cluster_criterios_avaliacaos_url, params: { cluster_criterios_avaliacao: { nome: @cluster_criterios_avaliacao.nome } }
    end

    assert_redirected_to cluster_criterios_avaliacao_url(ClusterCriteriosAvaliacao.last)
  end

  test "should show cluster_criterios_avaliacao" do
    get cluster_criterios_avaliacao_url(@cluster_criterios_avaliacao)
    assert_response :success
  end

  test "should get edit" do
    get edit_cluster_criterios_avaliacao_url(@cluster_criterios_avaliacao)
    assert_response :success
  end

  test "should update cluster_criterios_avaliacao" do
    patch cluster_criterios_avaliacao_url(@cluster_criterios_avaliacao), params: { cluster_criterios_avaliacao: { nome: @cluster_criterios_avaliacao.nome } }
    assert_redirected_to cluster_criterios_avaliacao_url(@cluster_criterios_avaliacao)
  end

  test "should destroy cluster_criterios_avaliacao" do
    assert_difference('ClusterCriteriosAvaliacao.count', -1) do
      delete cluster_criterios_avaliacao_url(@cluster_criterios_avaliacao)
    end

    assert_redirected_to cluster_criterios_avaliacaos_url
  end
end
