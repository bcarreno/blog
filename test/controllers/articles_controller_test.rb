require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = articles(:published)
  end

  test "get index" do
    get :index
    assert_response :success
    assert_select '.article_body h1', false
    assert_select '.article_body p', 'This is HTML'
    assert_select 'h2 a', {count: 1, text: articles(:published).title}
    assert_select 'h2 a', {count: 0, text: articles(:draft).title}
  end

  test "get index article with markdown" do
    @article.update_attributes! :markdown => true
    get :index
    assert_response :success
    assert_select '.article_body h1', 'This is markdown'
    assert_select '.article_body p', 'This is HTML'
  end

  test "get index logged in as regular user" do
    login_user(:regular)
    get :index
    assert_response :success
    assert_select 'h2 a', {count: 1, text: articles(:published).title}
    assert_select 'h2 a', {count: 0, text: articles(:draft).title}
  end

  test "get index logged in as admin" do
    login_user(:admin)
    get :index
    assert_response :success
    assert_select 'h2 a', {count: 1, text: articles(:published).title}
    assert_select 'h2 a', {count: 1, text: articles(:draft).title}
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
    assert_difference('Article.count', 0) do
      post :create, params: { article: { body: @article.body, keywords: @article.keywords,
                                         title: @article.title } }
    end
    assert_redirected_to login_path
  end

  test "post create logged in as regular user" do
    login_user(:regular)
    assert_difference('Article.count', 0) do
      post :create, params: { article: { body: @article.body, keywords: @article.keywords,
                                         title: @article.title } }
    end
    assert_redirected_to root_path
  end

  test "post create logged in as admin" do
    login_user(:admin)
    assert_difference('Article.count') do
      post :create, params: { article: { body: 'foo', title: 'xyzzy' } }
    end
    assert_redirected_to article_path(Article.find_by(title: 'xyzzy'))
  end

  test "get show" do
    get :show, params: { id: @article.to_param }
    assert_response :success
    assert_select '#comments_count', '2 comments'
    assert_select '.article_body h1', false
    assert_select '.article_body p', 'This is HTML'
  end

  test "get show article with markdown" do
    @article.update_attributes! :markdown => true
    get :show, params: { id: @article.to_param }
    assert_select '.article_body h1', 'This is markdown'
    assert_select '.article_body p', 'This is HTML'
  end

  test "get show without comments" do
    get :show, params: { id: articles(:unpopular).to_param }
    assert_response :success
    assert_select '#comments_count', ''
  end

  test "get show unpublished article" do
    get :show, params: { id: articles(:draft).to_param }
    assert_redirected_to articles_path
  end

  test 'get show article by slug' do
    get :show, params: { id: 'published-article' }
    assert_response :success
  end

  test 'get show non-existent article' do
    get :show, params: { id: 'foo' }
    assert_redirected_to articles_url
  end

  test "get show unpublished article logged in as regular user" do
    login_user(:regular)
    get :show, params: { id: articles(:draft).to_param }
    assert_redirected_to articles_path
  end

  test "get show unpublished article logged in as admin" do
    login_user(:admin)
    get :show, params: { id: articles(:draft).to_param }
    assert_response :success
  end

  test "get edit" do
    get :edit, params: { id: @article }
    assert_redirected_to login_path
  end

  test "get edit logged in as regular user" do
    login_user(:regular)
    get :edit, params: { id: @article }
    assert_redirected_to root_path
  end

  test "get edit logged in as admin" do
    login_user(:admin)
    get :edit, params: { id: @article }
    assert_response :success
  end

  test "patch update" do
    patch :update, params: { id: @article, article: { body: @article.body, keywords: @article.keywords,
                                                      title: @article.title } }
    assert_redirected_to login_path
  end

  test "patch update logged in as regular user" do
    login_user(:regular)
    patch :update, params: { id: @article, article: { body: @article.body, keywords: @article.keywords,
                                                      title: @article.title } }
    assert_redirected_to root_path
  end

  test "patch update logged in as admin" do
    login_user(:admin)
    patch :update, params: { id: @article, article: { body: @article.body, keywords: @article.keywords,
                                                      title: @article.title } }
    assert_response :success
  end

  test "delete destroy" do
    assert_difference('Article.count', 0) do
      delete :destroy, params: { id: @article }
    end
    assert_redirected_to login_path
  end

  test "delete destroy logged in as regular user" do
    login_user(:regular)
    assert_difference('Article.count', 0) do
      delete :destroy, params: { id: @article }
    end
    assert_redirected_to root_path
  end

  test "delete destroy logged in as admin" do
    login_user(:admin)
    assert_difference('Article.count', -1) do
      delete :destroy, params: { id: @article }
    end
    assert_redirected_to articles_path
  end
end
