require "application_system_test_case"

class RecurrencesTest < ApplicationSystemTestCase
  setup do
    @recurrence = recurrences(:one)
  end

  test "visiting the index" do
    visit recurrences_url
    assert_selector "h1", text: "Recurrences"
  end

  test "creating a Recurrence" do
    visit recurrences_url
    click_on "New Recurrence"

    fill_in "Amount", with: @recurrence.amount
    fill_in "Client", with: @recurrence.client_id
    fill_in "Processing date", with: @recurrence.processing_date
    fill_in "Reprocessing date", with: @recurrence.reprocessing_date
    fill_in "Status", with: @recurrence.status
    fill_in "Type", with: @recurrence.type
    fill_in "Validate", with: @recurrence.validate
    click_on "Create Recurrence"

    assert_text "Recurrence was successfully created"
    click_on "Back"
  end

  test "updating a Recurrence" do
    visit recurrences_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @recurrence.amount
    fill_in "Client", with: @recurrence.client_id
    fill_in "Processing date", with: @recurrence.processing_date
    fill_in "Reprocessing date", with: @recurrence.reprocessing_date
    fill_in "Status", with: @recurrence.status
    fill_in "Type", with: @recurrence.type
    fill_in "Validate", with: @recurrence.validate
    click_on "Update Recurrence"

    assert_text "Recurrence was successfully updated"
    click_on "Back"
  end

  test "destroying a Recurrence" do
    visit recurrences_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recurrence was successfully destroyed"
  end
end
