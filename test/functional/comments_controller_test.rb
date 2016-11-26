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
    # check commented posted?
  end
end

=begin
  test "post create" do
    assert_difference('Category.count', 0) do
      post :create, category: { description: @category.description, name: @category.name }
    end
    assert_redirected_to login_path
    assert_nil assigns(:category)
  end

  test "post create logged in as regular user" do
    login_user(:regular)
    assert_difference('Category.count', 0) do
      post :create, category: { description: @category.description, name: @category.name }
    end
    assert_redirected_to root_path
    assert_nil assigns(:category)
  end

  test "post create logged in as admin" do
    login_user(:admin)
    assert_difference('Category.count') do
      post :create, category: { description: @category.description, name: @category.name }
    end
    assert_redirected_to category_path(assigns(:category))
  end
=end



__END__



  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: { article_id: @comment.article_id, body: @comment.body, email: @comment.email, name: @comment.name }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should show comment" do
    get :show, id: @comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment
    assert_response :success
  end

  test "should update comment" do
    put :update, id: @comment, comment: { article_id: @comment.article_id, body: @comment.body, email: @comment.email, name: @comment.name }
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to comments_path
  end
end
