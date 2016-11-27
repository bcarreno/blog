require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:positive)
  end

  test "should create comment" do
    assert_difference ['Comment.count', 'ActionMailer::Base.deliveries.size'], +1 do
      post :create, article_id: @comment.article_id,
                    comment: { body: @comment.body, email: @comment.email, name: @comment.name }
    end
    assert_response :success
    # check commented posted????
  end

  test "get edit" do
    get :edit, article_id: @comment.article.to_param, id: @comment.to_param
    assert_redirected_to login_path
    assert_nil assigns(:comment)
  end

  test "get edit logged in as regular user" do
    login_user(:regular)
    get :edit, article_id: @comment.article.to_param, id: @comment.to_param
    assert_redirected_to root_path
    assert_nil assigns(:comment)
  end

  test "get edit logged in as admin" do
    login_user(:admin)
    get :edit, article_id: @comment.article.to_param, id: @comment.to_param
    assert_response :success
    assert assigns(:comment)
  end

  test 'get edit comments closed' do
    login_user(:admin)
    @comment.article.update_attributes!(comments_allowed: false)
    get :edit, article_id: @comment.article.to_param, id: @comment.to_param
    assert_redirected_to article_path(@comment.article, :anchor => 'comments')
  end

  test 'get edit comment does not belong to article' do
    login_user(:admin)
    get :edit, article_id: articles(:unpopular).to_param, id: @comment.to_param
    assert_response :missing
  end

  test "put update" do
    put :update, article_id: @comment.article.to_param, id: @comment.to_param
    assert_redirected_to login_path
    assert_nil assigns(:comment)
  end

  test "put update logged in as regular user" do
    login_user(:regular)
    put :update, article_id: @comment.article.to_param, id: @comment.to_param
    assert_redirected_to root_path
    assert_nil assigns(:comment)
  end

  test "put update logged in as admin" do
    login_user(:admin)
    put :update, article_id: @comment.article.to_param, id: @comment.to_param
    assert_redirected_to article_path(@comment.article)
  end

  test 'put update comments closed' do
    login_user(:admin)
    @comment.article.update_attributes!(comments_allowed: false)
    put :update, article_id: @comment.article.to_param, id: @comment.to_param
    assert_redirected_to article_path(@comment.article.to_param)
  end

  test 'put update comment does not belong to article' do
    login_user(:admin)
    put :update, article_id: articles(:unpopular).to_param, id: @comment.to_param
    assert_response :missing
  end

  test "delete destroy" do
    assert_difference('Comment.count', 0) do
      delete :destroy, article_id: @comment.article.to_param, id: @comment.to_param
    end
    assert_redirected_to login_path
  end

  test "delete destroy logged in as regular user" do
    login_user(:regular)
    assert_difference('Comment.count', 0) do
      delete :destroy, article_id: @comment.article.to_param, id: @comment.to_param
    end
    assert_redirected_to root_path
  end

  test "delete destroy logged in as admin" do
    login_user(:admin)
    assert_difference('Comment.count', -1) do
      delete :destroy, article_id: @comment.article.to_param, id: @comment.to_param
    end
    assert_redirected_to article_path(@comment.article, :anchor => 'comments')
  end
end
