require "application_system_test_case"

class CatalogoCompeticaosTest < ApplicationSystemTestCase
  setup do
    @catalogo_competicao = catalogo_competicaos(:one)
  end

  test "visiting the index" do
    visit catalogo_competicaos_url
    assert_selector "h1", text: "Catalogo Competicaos"
  end

  test "creating a Catalogo competicao" do
    visit catalogo_competicaos_url
    click_on "New Catalogo Competicao"

    fill_in "Competicaos eventos", with: @catalogo_competicao.competicaos_eventos
    fill_in "Qtd catalogos", with: @catalogo_competicao.qtd_catalogos
    fill_in "Qtd inscritos", with: @catalogo_competicao.qtd_inscritos
    click_on "Create Catalogo competicao"

    assert_text "Catalogo competicao was successfully created"
    click_on "Back"
  end

  test "updating a Catalogo competicao" do
    visit catalogo_competicaos_url
    click_on "Edit", match: :first

    fill_in "Competicaos eventos", with: @catalogo_competicao.competicaos_eventos
    fill_in "Qtd catalogos", with: @catalogo_competicao.qtd_catalogos
    fill_in "Qtd inscritos", with: @catalogo_competicao.qtd_inscritos
    click_on "Update Catalogo competicao"

    assert_text "Catalogo competicao was successfully updated"
    click_on "Back"
  end

  test "destroying a Catalogo competicao" do
    visit catalogo_competicaos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Catalogo competicao was successfully destroyed"
  end
end
