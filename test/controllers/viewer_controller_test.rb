require 'test_helper'

class ViewerControllerTest < ActionController::TestCase
  test "should get pgp_key" do
    get :pgp_key
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
