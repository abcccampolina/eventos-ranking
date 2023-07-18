require "application_system_test_case"

class CardTokensTest < ApplicationSystemTestCase
  setup do
    @card_token = card_tokens(:one)
  end

  test "visiting the index" do
    visit card_tokens_url
    assert_selector "h1", text: "Card Tokens"
  end

  test "creating a Card token" do
    visit card_tokens_url
    click_on "New Card Token"

    fill_in "Client", with: @card_token.client_id
    fill_in "Code", with: @card_token.code
    fill_in "Name", with: @card_token.name
    fill_in "Number", with: @card_token.number
    fill_in "Status", with: @card_token.status
    click_on "Create Card token"

    assert_text "Card token was successfully created"
    click_on "Back"
  end

  test "updating a Card token" do
    visit card_tokens_url
    click_on "Edit", match: :first

    fill_in "Client", with: @card_token.client_id
    fill_in "Code", with: @card_token.code
    fill_in "Name", with: @card_token.name
    fill_in "Number", with: @card_token.number
    fill_in "Status", with: @card_token.status
    click_on "Update Card token"

    assert_text "Card token was successfully updated"
    click_on "Back"
  end

  test "destroying a Card token" do
    visit card_tokens_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Card token was successfully destroyed"
  end
end
