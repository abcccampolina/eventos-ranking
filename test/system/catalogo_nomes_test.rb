require "application_system_test_case"

class CatalogoNomesTest < ApplicationSystemTestCase
  setup do
    @catalogo_nome = catalogo_nomes(:one)
  end

  test "visiting the index" do
    visit catalogo_nomes_url
    assert_selector "h1", text: "Catalogo Nomes"
  end

  test "creating a Catalogo nome" do
    visit catalogo_nomes_url
    click_on "New Catalogo Nome"

    fill_in "Competicaos eventos", with: @catalogo_nome.competicaos_eventos_id
    fill_in "Nome", with: @catalogo_nome.nome
    fill_in "Ordem nome", with: @catalogo_nome.ordem_nome
    click_on "Create Catalogo nome"

    assert_text "Catalogo nome was successfully created"
    click_on "Back"
  end

  test "updating a Catalogo nome" do
    visit catalogo_nomes_url
    click_on "Edit", match: :first

    fill_in "Competicaos eventos", with: @catalogo_nome.competicaos_eventos_id
    fill_in "Nome", with: @catalogo_nome.nome
    fill_in "Ordem nome", with: @catalogo_nome.ordem_nome
    click_on "Update Catalogo nome"

    assert_text "Catalogo nome was successfully updated"
    click_on "Back"
  end

  test "destroying a Catalogo nome" do
    visit catalogo_nomes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Catalogo nome was successfully destroyed"
  end
end
