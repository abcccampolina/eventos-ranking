require "application_system_test_case"

class CriteriosAvaliacaosTest < ApplicationSystemTestCase
  setup do
    @criterios_avaliacao = criterios_avaliacaos(:one)
  end

  test "visiting the index" do
    visit criterios_avaliacaos_url
    assert_selector "h1", text: "Criterios Avaliacaos"
  end

  test "creating a Criterios avaliacao" do
    visit criterios_avaliacaos_url
    click_on "New Criterios Avaliacao"

    fill_in "Cluster criterio avaliacao", with: @criterios_avaliacao.cluster_criterios_avaliacao_id
    fill_in "Metodo", with: @criterios_avaliacao.metodo
    fill_in "Nome", with: @criterios_avaliacao.nome
    fill_in "Peso", with: @criterios_avaliacao.peso
    click_on "Create Criterios avaliacao"

    assert_text "Criterios avaliacao was successfully created"
    click_on "Back"
  end

  test "updating a Criterios avaliacao" do
    visit criterios_avaliacaos_url
    click_on "Edit", match: :first

    fill_in "Cluster criterio avaliacao", with: @criterios_avaliacao.cluster_criterios_avaliacao_id
    fill_in "Metodo", with: @criterios_avaliacao.metodo
    fill_in "Nome", with: @criterios_avaliacao.nome
    fill_in "Peso", with: @criterios_avaliacao.peso
    click_on "Update Criterios avaliacao"

    assert_text "Criterios avaliacao was successfully updated"
    click_on "Back"
  end

  test "destroying a Criterios avaliacao" do
    visit criterios_avaliacaos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Criterios avaliacao was successfully destroyed"
  end
end
