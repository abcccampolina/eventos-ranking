require 'test_helper'

class InscricaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inscricao = inscricaos(:one)
  end

  test "should get index" do
    get inscricaos_url
    assert_response :success
  end

  test "should get new" do
    get new_inscricao_url
    assert_response :success
  end

  test "should create inscricao" do
    assert_difference('Inscricao.count') do
      post inscricaos_url, params: { inscricao: { criador_id: @inscricao.criador_id, expositor_id: @inscricao.expositor_id, srg_animal_id: @inscricao.srg_animal_id, status: @inscricao.status } }
    end

    assert_redirected_to inscricao_url(Inscricao.last)
  end

  test "should show inscricao" do
    get inscricao_url(@inscricao)
    assert_response :success
  end

  test "should get edit" do
    get edit_inscricao_url(@inscricao)
    assert_response :success
  end

  test "should update inscricao" do
    patch inscricao_url(@inscricao), params: { inscricao: { criador_id: @inscricao.criador_id, expositor_id: @inscricao.expositor_id, srg_animal_id: @inscricao.srg_animal_id, status: @inscricao.status } }
    assert_redirected_to inscricao_url(@inscricao)
  end

  test "should destroy inscricao" do
    assert_difference('Inscricao.count', -1) do
      delete inscricao_url(@inscricao)
    end

    assert_redirected_to inscricaos_url
  end
end
