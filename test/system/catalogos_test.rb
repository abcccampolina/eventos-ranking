require "application_system_test_case"

class CatalogosTest < ApplicationSystemTestCase
  setup do
    @catalogo = catalogos(:one)
  end

  test "visiting the index" do
    visit catalogos_url
    assert_selector "h1", text: "Catalogos"
  end

  test "creating a Catalogo" do
    visit catalogos_url
    click_on "New Catalogo"

    fill_in "Competicao evento", with: @catalogo.competicao_evento_id
    fill_in "Inscricaos", with: @catalogo.inscricaos_id
    fill_in "Nome catalogo", with: @catalogo.nome_catalogo
    click_on "Create Catalogo"

    assert_text "Catalogo was successfully created"
    click_on "Back"
  end

  test "updating a Catalogo" do
    visit catalogos_url
    click_on "Edit", match: :first

    fill_in "Competicao evento", with: @catalogo.competicao_evento_id
    fill_in "Inscricaos", with: @catalogo.inscricaos_id
    fill_in "Nome catalogo", with: @catalogo.nome_catalogo
    click_on "Update Catalogo"

    assert_text "Catalogo was successfully updated"
    click_on "Back"
  end

  test "destroying a Catalogo" do
    visit catalogos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Catalogo was successfully destroyed"
  end
end
