require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  test "get index" do
    get :index
    assert_redirected_to login_path
  end

  test "get index logged in as regular user" do
    login_user(:regular)
    get :index
    assert_response :success
  end

  test "get show" do
    get :show, base: 'avatar_200x200', format: 'png'
    assert_redirected_to login_path
  end

  test "get show logged in as regular user" do
    login_user(:regular)
    get :show, base: 'avatar_200x200', format: 'png'
    assert_response :success
    assert_equal 'image/png', response.content_type
  end

  test "breaking outside allowed directory" do
    login_user(:regular)
    filename = '../users.yml'
    assert File.exist?(File.expand_path(filename, PRIVATE_ASSETS_PATH))
    base, extension = filename.split(/\b\.\b/)
    get :show, base: base, format: extension
    assert_response :missing
    assert_equal 'text/html', response.content_type
  end
end
