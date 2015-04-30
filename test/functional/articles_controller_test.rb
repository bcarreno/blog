require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = articles(:published)
  end

  test "get index" do
    get :index
    assert_response :success
    articles = assigns(:articles)
    assert articles.include?(articles(:published))
    refute articles.include?(articles(:draft))
  end

  test "get index logged in as regular user" do
    login_user(:regular)
    get :index
    articles = assigns(:articles)
    assert articles.include?(articles(:published))
    refute articles.include?(articles(:draft))
  end

  test "get index logged in as admin" do
    login_user(:admin)
    get :index
    articles = assigns(:articles)
    assert articles.include?(articles(:published))
    assert articles.include?(articles(:draft))
  end

  test "get new" do
    get :new
    assert_redirected_to root_path
    assert_nil assigns(:articles)
  end

  test "get new logged in as regular user" do
    login_user(:regular)
    get :new
    assert_redirected_to root_path
    assert_nil assigns(:articles)
  end

  test "get new logged in as admin" do
    login_user(:admin)
    get :new
    assert_response :success
    assert assigns(:articles)
  end
end
__END__





  test "should create article" do
    assert_difference('Article.count') do
      post :create, article: { body: @article.body, keywords: @article.keywords, title: @article.title }
    end

    assert_redirected_to article_path(assigns(:article))
  end

  test "should show article" do
    get :show, id: @article
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article
    assert_response :success
  end

  test "should update article" do
    put :update, id: @article, article: { body: @article.body, keywords: @article.keywords, title: @article.title }
    assert_redirected_to article_path(assigns(:article))
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end

    assert_redirected_to articles_path
  end
end
