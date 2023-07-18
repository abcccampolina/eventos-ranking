require "application_system_test_case"

class ParametroInscricaosTest < ApplicationSystemTestCase
  setup do
    @parametro_inscricao = parametro_inscricaos(:one)
  end

  test "visiting the index" do
    visit parametro_inscricaos_url
    assert_selector "h1", text: "Parametro Inscricaos"
  end

  test "creating a Parametro inscricao" do
    visit parametro_inscricaos_url
    click_on "New Parametro Inscricao"

    fill_in "Coluna parametro", with: @parametro_inscricao.coluna_parametro
    fill_in "Competicao", with: @parametro_inscricao.competicao_id
    fill_in "Nome", with: @parametro_inscricao.nome
    fill_in "Operador parametro", with: @parametro_inscricao.operador_parametro
    fill_in "Valor parametro", with: @parametro_inscricao.valor_parametro
    click_on "Create Parametro inscricao"

    assert_text "Parametro inscricao was successfully created"
    click_on "Back"
  end

  test "updating a Parametro inscricao" do
    visit parametro_inscricaos_url
    click_on "Edit", match: :first

    fill_in "Coluna parametro", with: @parametro_inscricao.coluna_parametro
    fill_in "Competicao", with: @parametro_inscricao.competicao_id
    fill_in "Nome", with: @parametro_inscricao.nome
    fill_in "Operador parametro", with: @parametro_inscricao.operador_parametro
    fill_in "Valor parametro", with: @parametro_inscricao.valor_parametro
    click_on "Update Parametro inscricao"

    assert_text "Parametro inscricao was successfully updated"
    click_on "Back"
  end

  test "destroying a Parametro inscricao" do
    visit parametro_inscricaos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Parametro inscricao was successfully destroyed"
  end
end
