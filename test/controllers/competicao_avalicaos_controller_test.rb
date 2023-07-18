require 'test_helper'

class CompeticaoAvalicaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @competicao_avalicao = competicao_avalicaos(:one)
  end

  test "should get index" do
    get competicao_avalicaos_url
    assert_response :success
  end

  test "should get new" do
    get new_competicao_avalicao_url
    assert_response :success
  end

  test "should create competicao_avalicao" do
    assert_difference('CompeticaoAvalicao.count') do
      post competicao_avalicaos_url, params: { competicao_avalicao: { competicao_juri_id: @competicao_avalicao.competicao_juri_id, criterios_competicao_id: @competicao_avalicao.criterios_competicao_id, data: @competicao_avalicao.data, inscricao_id: @competicao_avalicao.inscricao_id, nota: @competicao_avalicao.nota } }
    end

    assert_redirected_to competicao_avalicao_url(CompeticaoAvalicao.last)
  end

  test "should show competicao_avalicao" do
    get competicao_avalicao_url(@competicao_avalicao)
    assert_response :success
  end

  test "should get edit" do
    get edit_competicao_avalicao_url(@competicao_avalicao)
    assert_response :success
  end

  test "should update competicao_avalicao" do
    patch competicao_avalicao_url(@competicao_avalicao), params: { competicao_avalicao: { competicao_juri_id: @competicao_avalicao.competicao_juri_id, criterios_competicao_id: @competicao_avalicao.criterios_competicao_id, data: @competicao_avalicao.data, inscricao_id: @competicao_avalicao.inscricao_id, nota: @competicao_avalicao.nota } }
    assert_redirected_to competicao_avalicao_url(@competicao_avalicao)
  end

  test "should destroy competicao_avalicao" do
    assert_difference('CompeticaoAvalicao.count', -1) do
      delete competicao_avalicao_url(@competicao_avalicao)
    end

    assert_redirected_to competicao_avalicaos_url
  end
end
