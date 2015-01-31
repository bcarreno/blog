require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @user = users(:regular)
  end

  test "get new" do
    get :new
    assert_response :success
  end

  # what if already logged in?
  test "get new as a logged in user" do
    login_user(:regular)
    get :new
    assert_response :success
  end

  # what if already logged in? (make new test)
  test "login with correct credentials" do
    post :create, username: @user.username, password: 'secret'
    assert_equal @user.id, session[:user_id]
  end

  test "login with bad credentials" do
    post :create, username: @user.username, password: 'bad secret'
    assert_nil session[:user_id]
  end

  test "logout" do
    login_user(:regular)
    get :destroy
    assert_nil session[:user_id]
    assert_redirected_to root_path
  end

  test "logout without being logged in" do
    get :destroy
    assert_nil session[:user_id]
    assert_redirected_to root_path
  end

end
