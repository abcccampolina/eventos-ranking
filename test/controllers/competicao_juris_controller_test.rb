require 'test_helper'

class CompeticaoJurisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @competicao_juri = competicao_juris(:one)
  end

  test "should get index" do
    get competicao_juris_url
    assert_response :success
  end

  test "should get new" do
    get new_competicao_juri_url
    assert_response :success
  end

  test "should create competicao_juri" do
    assert_difference('CompeticaoJuri.count') do
      post competicao_juris_url, params: { competicao_juri: { competicaos_evento_id: @competicao_juri.competicaos_evento_id, user_id: @competicao_juri.user_id } }
    end

    assert_redirected_to competicao_juri_url(CompeticaoJuri.last)
  end

  test "should show competicao_juri" do
    get competicao_juri_url(@competicao_juri)
    assert_response :success
  end

  test "should get edit" do
    get edit_competicao_juri_url(@competicao_juri)
    assert_response :success
  end

  test "should update competicao_juri" do
    patch competicao_juri_url(@competicao_juri), params: { competicao_juri: { competicaos_evento_id: @competicao_juri.competicaos_evento_id, user_id: @competicao_juri.user_id } }
    assert_redirected_to competicao_juri_url(@competicao_juri)
  end

  test "should destroy competicao_juri" do
    assert_difference('CompeticaoJuri.count', -1) do
      delete competicao_juri_url(@competicao_juri)
    end

    assert_redirected_to competicao_juris_url
  end
end
