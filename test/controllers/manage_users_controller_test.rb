require 'test_helper'

class ManageUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_user = manage_users(:one)
  end

  test "should get index" do
    get manage_users_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_user_url
    assert_response :success
  end

  # test "should create manage_user" do
  #   assert_difference('ManageUser.count') do
  #     post manage_users_url, params: { manage_user: { email: @manage_user.email, name: @manage_user.name } }
  #   end

  #   assert_redirected_to manage_user_url(ManageUser.last)
  # end

  test "should show manage_user" do
    get manage_user_url(@manage_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_user_url(@manage_user)
    assert_response :success
  end

  test "should update manage_user" do
    patch manage_user_url(@manage_user), params: { manage_user: { email: @manage_user.email, name: @manage_user.name } }
    assert_redirected_to manage_user_url(@manage_user)
  end

  # test "should destroy manage_user" do
  #   assert_difference('ManageUser.count', -1) do
  #     delete manage_user_url(@manage_user)
  #   end

  #   assert_redirected_to manage_users_url
  # end
end
