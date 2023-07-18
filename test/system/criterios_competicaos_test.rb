require "application_system_test_case"

class CriteriosCompeticaosTest < ApplicationSystemTestCase
  setup do
    @criterios_competicao = criterios_competicaos(:one)
  end

  test "visiting the index" do
    visit criterios_competicaos_url
    assert_selector "h1", text: "Criterios Competicaos"
  end

  test "creating a Criterios competicao" do
    visit criterios_competicaos_url
    click_on "New Criterios Competicao"

    fill_in "Competicao", with: @criterios_competicao.competicao_id
    fill_in "Criterios avaliacao", with: @criterios_competicao.criterios_avaliacao_id
    click_on "Create Criterios competicao"

    assert_text "Criterios competicao was successfully created"
    click_on "Back"
  end

  test "updating a Criterios competicao" do
    visit criterios_competicaos_url
    click_on "Edit", match: :first

    fill_in "Competicao", with: @criterios_competicao.competicao_id
    fill_in "Criterios avaliacao", with: @criterios_competicao.criterios_avaliacao_id
    click_on "Update Criterios competicao"

    assert_text "Criterios competicao was successfully updated"
    click_on "Back"
  end

  test "destroying a Criterios competicao" do
    visit criterios_competicaos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Criterios competicao was successfully destroyed"
  end
end
