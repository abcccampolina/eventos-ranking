require 'test_helper'

class InscricaosCompeticaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inscricaos_competicao = inscricaos_competicaos(:one)
  end

  test "should get index" do
    get inscricaos_competicaos_url
    assert_response :success
  end

  test "should get new" do
    get new_inscricaos_competicao_url
    assert_response :success
  end

  test "should create inscricaos_competicao" do
    assert_difference('InscricaosCompeticao.count') do
      post inscricaos_competicaos_url, params: { inscricaos_competicao: { competicao_id: @inscricaos_competicao.competicao_id, inscricao_id: @inscricaos_competicao.inscricao_id } }
    end

    assert_redirected_to inscricaos_competicao_url(InscricaosCompeticao.last)
  end

  test "should show inscricaos_competicao" do
    get inscricaos_competicao_url(@inscricaos_competicao)
    assert_response :success
  end

  test "should get edit" do
    get edit_inscricaos_competicao_url(@inscricaos_competicao)
    assert_response :success
  end

  test "should update inscricaos_competicao" do
    patch inscricaos_competicao_url(@inscricaos_competicao), params: { inscricaos_competicao: { competicao_id: @inscricaos_competicao.competicao_id, inscricao_id: @inscricaos_competicao.inscricao_id } }
    assert_redirected_to inscricaos_competicao_url(@inscricaos_competicao)
  end

  test "should destroy inscricaos_competicao" do
    assert_difference('InscricaosCompeticao.count', -1) do
      delete inscricaos_competicao_url(@inscricaos_competicao)
    end

    assert_redirected_to inscricaos_competicaos_url
  end
end
