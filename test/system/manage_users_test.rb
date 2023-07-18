require "application_system_test_case"

class ManageUsersTest < ApplicationSystemTestCase
  setup do
    @manage_user = manage_users(:one)
  end

  test "visiting the index" do
    visit manage_users_url
    assert_selector "h1", text: "Manage Users"
  end

  test "creating a Manage user" do
    visit manage_users_url
    click_on "New Manage User"

    fill_in "Email", with: @manage_user.email
    fill_in "Name", with: @manage_user.name
    click_on "Create Manage user"

    assert_text "Manage user was successfully created"
    click_on "Back"
  end

  test "updating a Manage user" do
    visit manage_users_url
    click_on "Edit", match: :first

    fill_in "Email", with: @manage_user.email
    fill_in "Name", with: @manage_user.name
    click_on "Update Manage user"

    assert_text "Manage user was successfully updated"
    click_on "Back"
  end

  test "destroying a Manage user" do
    visit manage_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Manage user was successfully destroyed"
  end
end
