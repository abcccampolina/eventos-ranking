require "application_system_test_case"

class CompeticaoAvalicaosTest < ApplicationSystemTestCase
  setup do
    @competicao_avalicao = competicao_avalicaos(:one)
  end

  test "visiting the index" do
    visit competicao_avalicaos_url
    assert_selector "h1", text: "Competicao Avalicaos"
  end

  test "creating a Competicao avalicao" do
    visit competicao_avalicaos_url
    click_on "New Competicao Avalicao"

    fill_in "Competicao juri", with: @competicao_avalicao.competicao_juri_id
    fill_in "Criterios competicao", with: @competicao_avalicao.criterios_competicao_id
    fill_in "Data", with: @competicao_avalicao.data
    fill_in "Inscricao", with: @competicao_avalicao.inscricao_id
    fill_in "Nota", with: @competicao_avalicao.nota
    click_on "Create Competicao avalicao"

    assert_text "Competicao avalicao was successfully created"
    click_on "Back"
  end

  test "updating a Competicao avalicao" do
    visit competicao_avalicaos_url
    click_on "Edit", match: :first

    fill_in "Competicao juri", with: @competicao_avalicao.competicao_juri_id
    fill_in "Criterios competicao", with: @competicao_avalicao.criterios_competicao_id
    fill_in "Data", with: @competicao_avalicao.data
    fill_in "Inscricao", with: @competicao_avalicao.inscricao_id
    fill_in "Nota", with: @competicao_avalicao.nota
    click_on "Update Competicao avalicao"

    assert_text "Competicao avalicao was successfully updated"
    click_on "Back"
  end

  test "destroying a Competicao avalicao" do
    visit competicao_avalicaos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Competicao avalicao was successfully destroyed"
  end
end
