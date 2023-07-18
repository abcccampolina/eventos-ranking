require 'test_helper'

class CompeticaosEventosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @competicaos_evento = competicaos_eventos(:one)
  end

  test "should get index" do
    get competicaos_eventos_url
    assert_response :success
  end

  test "should get new" do
    get new_competicaos_evento_url
    assert_response :success
  end

  test "should create competicaos_evento" do
    assert_difference('CompeticaosEvento.count') do
      post competicaos_eventos_url, params: { competicaos_evento: { competicao_id: @competicaos_evento.competicao_id, evento_id: @competicaos_evento.evento_id } }
    end

    assert_redirected_to competicaos_evento_url(CompeticaosEvento.last)
  end

  test "should show competicaos_evento" do
    get competicaos_evento_url(@competicaos_evento)
    assert_response :success
  end

  test "should get edit" do
    get edit_competicaos_evento_url(@competicaos_evento)
    assert_response :success
  end

  test "should update competicaos_evento" do
    patch competicaos_evento_url(@competicaos_evento), params: { competicaos_evento: { competicao_id: @competicaos_evento.competicao_id, evento_id: @competicaos_evento.evento_id } }
    assert_redirected_to competicaos_evento_url(@competicaos_evento)
  end

  test "should destroy competicaos_evento" do
    assert_difference('CompeticaosEvento.count', -1) do
      delete competicaos_evento_url(@competicaos_evento)
    end

    assert_redirected_to competicaos_eventos_url
  end
end
