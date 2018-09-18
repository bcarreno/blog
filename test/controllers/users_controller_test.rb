require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user_attributes = {username: 'test', email: 'test@test.com', password: 'test', name: 'John Test'}
    @user_attributes[:password_confirmation] = @user_attributes[:password]
  end

  test "get new" do
    get :new
    assert_redirected_to login_path
  end

  test "get new logged in as regular user" do
    login_user(:regular)
    get :new
    assert_redirected_to root_path
  end

  test "get new logged in as admin" do
    login_user(:admin)
    get :new
    assert_response :success
  end

  test "post create" do
    assert_difference('User.count', 0) do
      post :create, params: { user: @user_attributes }
    end
    assert_redirected_to login_path
  end

  test "post create logged in as regular user" do
    login_user(:regular)
    assert_difference('User.count', 0) do
      post :create, params: { user: @user_attributes }
    end
    assert_redirected_to root_path
  end

  test "post create logged in as admin" do
    login_user(:admin)
    assert_difference('User.count') do
      post :create, params: { user: @user_attributes }
    end
    assert_redirected_to root_path
  end

  test "post create should not allow to create an admin user" do
    login_user(:admin)
    assert_raises(ActionController::UnpermittedParameters) do
      post :create, params: { user: @user_attributes.merge(admin: true) }
    end
  end

end
