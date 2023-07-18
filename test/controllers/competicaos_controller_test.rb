require 'test_helper'

class CompeticaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @competicao = competicaos(:one)
  end

  test "should get index" do
    get competicaos_url
    assert_response :success
  end

  test "should get new" do
    get new_competicao_url
    assert_response :success
  end

  test "should create competicao" do
    assert_difference('Competicao.count') do
      post competicaos_url, params: { competicao: { modalidade_id: @competicao.modalidade_id, nome: @competicao.nome, status: @competicao.status } }
    end

    assert_redirected_to competicao_url(Competicao.last)
  end

  test "should show competicao" do
    get competicao_url(@competicao)
    assert_response :success
  end

  test "should get edit" do
    get edit_competicao_url(@competicao)
    assert_response :success
  end

  test "should update competicao" do
    patch competicao_url(@competicao), params: { competicao: { modalidade_id: @competicao.modalidade_id, nome: @competicao.nome, status: @competicao.status } }
    assert_redirected_to competicao_url(@competicao)
  end

  test "should destroy competicao" do
    assert_difference('Competicao.count', -1) do
      delete competicao_url(@competicao)
    end

    assert_redirected_to competicaos_url
  end
end
