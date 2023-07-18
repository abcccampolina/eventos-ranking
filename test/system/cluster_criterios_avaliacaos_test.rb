require "application_system_test_case"

class ClusterCriteriosAvaliacaosTest < ApplicationSystemTestCase
  setup do
    @cluster_criterios_avaliacao = cluster_criterios_avaliacaos(:one)
  end

  test "visiting the index" do
    visit cluster_criterios_avaliacaos_url
    assert_selector "h1", text: "Cluster Criterios Avaliacaos"
  end

  test "creating a Cluster criterios avaliacao" do
    visit cluster_criterios_avaliacaos_url
    click_on "New Cluster Criterios Avaliacao"

    fill_in "Nome", with: @cluster_criterios_avaliacao.nome
    click_on "Create Cluster criterios avaliacao"

    assert_text "Cluster criterios avaliacao was successfully created"
    click_on "Back"
  end

  test "updating a Cluster criterios avaliacao" do
    visit cluster_criterios_avaliacaos_url
    click_on "Edit", match: :first

    fill_in "Nome", with: @cluster_criterios_avaliacao.nome
    click_on "Update Cluster criterios avaliacao"

    assert_text "Cluster criterios avaliacao was successfully updated"
    click_on "Back"
  end

  test "destroying a Cluster criterios avaliacao" do
    visit cluster_criterios_avaliacaos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cluster criterios avaliacao was successfully destroyed"
  end
end
