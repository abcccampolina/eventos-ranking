require "application_system_test_case"

class ContractsTest < ApplicationSystemTestCase
  setup do
    @contract = contracts(:one)
  end

  test "visiting the index" do
    visit contracts_url
    assert_selector "h1", text: "Contracts"
  end

  test "creating a Contract" do
    visit contracts_url
    click_on "New Contract"

    fill_in "Amount", with: @contract.amount
    fill_in "Client", with: @contract.client_id
    fill_in "Payment type", with: @contract.payment_type
    fill_in "Recurrence expiration", with: @contract.recurrence_expiration
    fill_in "Recurrence", with: @contract.recurrence_id
    fill_in "Status", with: @contract.status
    click_on "Create Contract"

    assert_text "Contract was successfully created"
    click_on "Back"
  end

  test "updating a Contract" do
    visit contracts_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @contract.amount
    fill_in "Client", with: @contract.client_id
    fill_in "Payment type", with: @contract.payment_type
    fill_in "Recurrence expiration", with: @contract.recurrence_expiration
    fill_in "Recurrence", with: @contract.recurrence_id
    fill_in "Status", with: @contract.status
    click_on "Update Contract"

    assert_text "Contract was successfully updated"
    click_on "Back"
  end

  test "destroying a Contract" do
    visit contracts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contract was successfully destroyed"
  end
end
