require "application_system_test_case"

class InscricaosCompeticaosTest < ApplicationSystemTestCase
  setup do
    @inscricaos_competicao = inscricaos_competicaos(:one)
  end

  test "visiting the index" do
    visit inscricaos_competicaos_url
    assert_selector "h1", text: "Inscricaos Competicaos"
  end

  test "creating a Inscricaos competicao" do
    visit inscricaos_competicaos_url
    click_on "New Inscricaos Competicao"

    fill_in "Competicao", with: @inscricaos_competicao.competicao_id
    fill_in "Inscricao", with: @inscricaos_competicao.inscricao_id
    click_on "Create Inscricaos competicao"

    assert_text "Inscricaos competicao was successfully created"
    click_on "Back"
  end

  test "updating a Inscricaos competicao" do
    visit inscricaos_competicaos_url
    click_on "Edit", match: :first

    fill_in "Competicao", with: @inscricaos_competicao.competicao_id
    fill_in "Inscricao", with: @inscricaos_competicao.inscricao_id
    click_on "Update Inscricaos competicao"

    assert_text "Inscricaos competicao was successfully updated"
    click_on "Back"
  end

  test "destroying a Inscricaos competicao" do
    visit inscricaos_competicaos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inscricaos competicao was successfully destroyed"
  end
end
