require "application_system_test_case"

class CompeticaoDesempatesTest < ApplicationSystemTestCase
  setup do
    @competicao_desempate = competicao_desempates(:one)
  end

  test "visiting the index" do
    visit competicao_desempates_url
    assert_selector "h1", text: "Competicao Desempates"
  end

  test "creating a Competicao desempate" do
    visit competicao_desempates_url
    click_on "New Competicao Desempate"

    fill_in "Competicao juri", with: @competicao_desempate.competicao_juri_id
    fill_in "Competicaos evento", with: @competicao_desempate.competicaos_evento_id
    fill_in "Criterios competicao", with: @competicao_desempate.criterios_competicao_id
    fill_in "Inscricao", with: @competicao_desempate.inscricao_id
    fill_in "Nota", with: @competicao_desempate.nota
    click_on "Create Competicao desempate"

    assert_text "Competicao desempate was successfully created"
    click_on "Back"
  end

  test "updating a Competicao desempate" do
    visit competicao_desempates_url
    click_on "Edit", match: :first

    fill_in "Competicao juri", with: @competicao_desempate.competicao_juri_id
    fill_in "Competicaos evento", with: @competicao_desempate.competicaos_evento_id
    fill_in "Criterios competicao", with: @competicao_desempate.criterios_competicao_id
    fill_in "Inscricao", with: @competicao_desempate.inscricao_id
    fill_in "Nota", with: @competicao_desempate.nota
    click_on "Update Competicao desempate"

    assert_text "Competicao desempate was successfully updated"
    click_on "Back"
  end

  test "destroying a Competicao desempate" do
    visit competicao_desempates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Competicao desempate was successfully destroyed"
  end
end
