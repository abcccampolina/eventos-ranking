require 'test_helper'

class CriteriosCompeticaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @criterios_competicao = criterios_competicaos(:one)
  end

  test "should get index" do
    get criterios_competicaos_url
    assert_response :success
  end

  test "should get new" do
    get new_criterios_competicao_url
    assert_response :success
  end

  test "should create criterios_competicao" do
    assert_difference('CriteriosCompeticao.count') do
      post criterios_competicaos_url, params: { criterios_competicao: { competicao_id: @criterios_competicao.competicao_id, criterios_avaliacao_id: @criterios_competicao.criterios_avaliacao_id } }
    end

    assert_redirected_to criterios_competicao_url(CriteriosCompeticao.last)
  end

  test "should show criterios_competicao" do
    get criterios_competicao_url(@criterios_competicao)
    assert_response :success
  end

  test "should get edit" do
    get edit_criterios_competicao_url(@criterios_competicao)
    assert_response :success
  end

  test "should update criterios_competicao" do
    patch criterios_competicao_url(@criterios_competicao), params: { criterios_competicao: { competicao_id: @criterios_competicao.competicao_id, criterios_avaliacao_id: @criterios_competicao.criterios_avaliacao_id } }
    assert_redirected_to criterios_competicao_url(@criterios_competicao)
  end

  test "should destroy criterios_competicao" do
    assert_difference('CriteriosCompeticao.count', -1) do
      delete criterios_competicao_url(@criterios_competicao)
    end

    assert_redirected_to criterios_competicaos_url
  end
end
