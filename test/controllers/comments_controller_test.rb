require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:positive)
  end

  test 'post create' do
    assert_difference ['@comment.article.comments.count', 'ActionMailer::Base.deliveries.size'], +1 do
      post :create, article_id: @comment.article.to_param,
        comment: { body: 'you made a typo', email: 'linguist@example.com', name: 'Louise Linguist' }
    end
    assert_response :success
    assert_select 'div.comment', /you made a typo/

    notification_email = ActionMailer::Base.deliveries.last
    assert_equal 'New comment',          notification_email.subject
    assert_equal 'target@example.com',   notification_email.to[0]
    assert_equal 'origin@example.com',   notification_email.from[0]
    assert_match(/linguist@example.com/, notification_email.body.to_s)
    assert_match(/you made a typo/,      notification_email.body.to_s)
  end

  test 'post create insufficient params' do
    assert_difference ['Comment.count', 'ActionMailer::Base.deliveries.size'], 0 do
      post :create, article_id: @comment.article.to_param,
        comment: { name: 'Louise Linguist' }
    end
    assert_response :success
    assert_match /can't be blank/, assigns(:comment).errors[:body].to_s
  end

  test 'deceive spam' do
    assert_difference ['Comment.count', 'ActionMailer::Base.deliveries.size'], 0 do
      post :create, article_id: @comment.article.to_param, subject: 'viagra on sale',
        comment: { body: '50% off', email: 'linguist@example.com', name: 'Louise Linguist' }
    end
    assert_response :success
    assert_select 'div.comment', /50% off/
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
    put :update, article_id: @comment.article.to_param, id: @comment.to_param, comment: { body: 'amended text' }
    assert_redirected_to article_path(@comment.article)
    assert_equal 'amended text', @comment.reload.body
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
    assert_difference('@comment.article.comments.count', -1) do
      delete :destroy, article_id: @comment.article.to_param, id: @comment.to_param
    end
    assert_redirected_to article_path(@comment.article, :anchor => 'comments')
  end
end
