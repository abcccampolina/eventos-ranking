require "application_system_test_case"

class CompeticaosEventosTest < ApplicationSystemTestCase
  setup do
    @competicaos_evento = competicaos_eventos(:one)
  end

  test "visiting the index" do
    visit competicaos_eventos_url
    assert_selector "h1", text: "Competicaos Eventos"
  end

  test "creating a Competicaos evento" do
    visit competicaos_eventos_url
    click_on "New Competicaos Evento"

    fill_in "Competicao", with: @competicaos_evento.competicao_id
    fill_in "Evento", with: @competicaos_evento.evento_id
    click_on "Create Competicaos evento"

    assert_text "Competicaos evento was successfully created"
    click_on "Back"
  end

  test "updating a Competicaos evento" do
    visit competicaos_eventos_url
    click_on "Edit", match: :first

    fill_in "Competicao", with: @competicaos_evento.competicao_id
    fill_in "Evento", with: @competicaos_evento.evento_id
    click_on "Update Competicaos evento"

    assert_text "Competicaos evento was successfully updated"
    click_on "Back"
  end

  test "destroying a Competicaos evento" do
    visit competicaos_eventos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Competicaos evento was successfully destroyed"
  end
end
