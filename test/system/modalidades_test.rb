require "application_system_test_case"

class ModalidadesTest < ApplicationSystemTestCase
  setup do
    @modalidade = modalidades(:one)
  end

  test "visiting the index" do
    visit modalidades_url
    assert_selector "h1", text: "Modalidades"
  end

  test "creating a Modalidade" do
    visit modalidades_url
    click_on "New Modalidade"

    fill_in "Nome", with: @modalidade.nome
    click_on "Create Modalidade"

    assert_text "Modalidade was successfully created"
    click_on "Back"
  end

  test "updating a Modalidade" do
    visit modalidades_url
    click_on "Edit", match: :first

    fill_in "Nome", with: @modalidade.nome
    click_on "Update Modalidade"

    assert_text "Modalidade was successfully updated"
    click_on "Back"
  end

  test "destroying a Modalidade" do
    visit modalidades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Modalidade was successfully destroyed"
  end
end
