require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:sports)
  end

  test "get index" do
    get :index
    assert_redirected_to login_path
  end

  test "get index logged in as regular user" do
    login_user(:regular)
    get :index
    assert_redirected_to root_path
  end

  test "get index logged in as admin" do
    login_user(:admin)
    get :index
    assert_response :success
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
    assert_difference('Category.count', 0) do
      post :create, params: { category: { description: @category.description, name: @category.name } }
    end
    assert_redirected_to login_path
  end

  test "post create logged in as regular user" do
    login_user(:regular)
    assert_difference('Category.count', 0) do
      post :create, params: { category: { description: @category.description, name: @category.name } }
    end
    assert_redirected_to root_path
  end

  test "post create logged in as admin" do
    login_user(:admin)
    assert_difference('Category.count') do
      post :create, params: { category: { description: 'Fun stuff', name: 'entertainment' } }
    end
    assert_redirected_to category_path(Category.find_by(name: 'entertainment'))
  end

  test "get show" do
    get :show, params: { id: @category.to_param }
    assert_redirected_to login_path
  end

  test "get show logged in as regular user" do
    login_user(:regular)
    get :show, params: { id: @category.to_param }
    assert_redirected_to root_path
  end

  test "get show logged in as admin" do
    login_user(:admin)
    get :show, params: { id: @category.to_param }
    assert_response :success
  end

  test "get edit" do
    get :edit, params: { id: @category.to_param }
    assert_redirected_to login_path
  end

  test "get edit logged in as regular user" do
    login_user(:regular)
    get :edit, params: { id: @category.to_param }
    assert_redirected_to root_path
  end

  test "get edit logged in as admin" do
    login_user(:admin)
    get :edit, params: { id: @category.to_param }
    assert_response :success
  end

  test "patch update" do
    patch :update, params: { id: @category.to_param,
                             category: { description: @category.description, name: @category.name } }
    assert_redirected_to login_path
  end

  test "patch update logged in as regular user" do
    login_user(:regular)
    patch :update, params: { id: @category,
                             category: { description: @category.description, name: @category.name } }
    assert_redirected_to root_path
  end

  test "patch update logged in as admin" do
    login_user(:admin)
    patch :update, params: { id: @category,
                             category: { description: @category.description, name: @category.name } }
    assert_redirected_to category_path(Category.find(@category.id))
  end

  test "delete destroy" do
    assert_difference('Category.count', 0) do
      delete :destroy, params: { id: @category.to_param }
    end
    assert_redirected_to login_path
  end

  test "delete destroy logged in as regular user" do
    login_user(:regular)
    assert_difference('Category.count', 0) do
      delete :destroy, params: { id: @category.to_param }
    end
    assert_redirected_to root_path
  end

  test "delete destroy logged in as admin" do
    login_user(:admin)
    assert_difference('Category.count', -1) do
      delete :destroy, params: { id: @category.to_param }
    end
    assert_redirected_to categories_path
  end
end
