require 'test_helper'

class CompeticaoDesempatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @competicao_desempate = competicao_desempates(:one)
  end

  test "should get index" do
    get competicao_desempates_url
    assert_response :success
  end

  test "should get new" do
    get new_competicao_desempate_url
    assert_response :success
  end

  test "should create competicao_desempate" do
    assert_difference('CompeticaoDesempate.count') do
      post competicao_desempates_url, params: { competicao_desempate: { competicao_juri_id: @competicao_desempate.competicao_juri_id, competicaos_evento_id: @competicao_desempate.competicaos_evento_id, criterios_competicao_id: @competicao_desempate.criterios_competicao_id, inscricao_id: @competicao_desempate.inscricao_id, nota: @competicao_desempate.nota } }
    end

    assert_redirected_to competicao_desempate_url(CompeticaoDesempate.last)
  end

  test "should show competicao_desempate" do
    get competicao_desempate_url(@competicao_desempate)
    assert_response :success
  end

  test "should get edit" do
    get edit_competicao_desempate_url(@competicao_desempate)
    assert_response :success
  end

  test "should update competicao_desempate" do
    patch competicao_desempate_url(@competicao_desempate), params: { competicao_desempate: { competicao_juri_id: @competicao_desempate.competicao_juri_id, competicaos_evento_id: @competicao_desempate.competicaos_evento_id, criterios_competicao_id: @competicao_desempate.criterios_competicao_id, inscricao_id: @competicao_desempate.inscricao_id, nota: @competicao_desempate.nota } }
    assert_redirected_to competicao_desempate_url(@competicao_desempate)
  end

  test "should destroy competicao_desempate" do
    assert_difference('CompeticaoDesempate.count', -1) do
      delete competicao_desempate_url(@competicao_desempate)
    end

    assert_redirected_to competicao_desempates_url
  end
end
