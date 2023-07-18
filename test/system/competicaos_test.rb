require "application_system_test_case"

class CompeticaosTest < ApplicationSystemTestCase
  setup do
    @competicao = competicaos(:one)
  end

  test "visiting the index" do
    visit competicaos_url
    assert_selector "h1", text: "Competicaos"
  end

  test "creating a Competicao" do
    visit competicaos_url
    click_on "New Competicao"

    fill_in "Modalidade", with: @competicao.modalidade_id
    fill_in "Nome", with: @competicao.nome
    fill_in "Status", with: @competicao.status
    click_on "Create Competicao"

    assert_text "Competicao was successfully created"
    click_on "Back"
  end

  test "updating a Competicao" do
    visit competicaos_url
    click_on "Edit", match: :first

    fill_in "Modalidade", with: @competicao.modalidade_id
    fill_in "Nome", with: @competicao.nome
    fill_in "Status", with: @competicao.status
    click_on "Update Competicao"

    assert_text "Competicao was successfully updated"
    click_on "Back"
  end

  test "destroying a Competicao" do
    visit competicaos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Competicao was successfully destroyed"
  end
end
