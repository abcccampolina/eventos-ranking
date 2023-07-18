require "application_system_test_case"

class CompeticaoJurisTest < ApplicationSystemTestCase
  setup do
    @competicao_juri = competicao_juris(:one)
  end

  test "visiting the index" do
    visit competicao_juris_url
    assert_selector "h1", text: "Competicao Juris"
  end

  test "creating a Competicao juri" do
    visit competicao_juris_url
    click_on "New Competicao Juri"

    fill_in "Competicaos evento", with: @competicao_juri.competicaos_evento_id
    fill_in "User", with: @competicao_juri.user_id
    click_on "Create Competicao juri"

    assert_text "Competicao juri was successfully created"
    click_on "Back"
  end

  test "updating a Competicao juri" do
    visit competicao_juris_url
    click_on "Edit", match: :first

    fill_in "Competicaos evento", with: @competicao_juri.competicaos_evento_id
    fill_in "User", with: @competicao_juri.user_id
    click_on "Update Competicao juri"

    assert_text "Competicao juri was successfully updated"
    click_on "Back"
  end

  test "destroying a Competicao juri" do
    visit competicao_juris_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Competicao juri was successfully destroyed"
  end
end
