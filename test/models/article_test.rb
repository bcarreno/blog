require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  test 'create new article as unpublished' do
    article = Article.new
    assert_difference('Article.count') do
      assert article.save
    end
    refute article.is_published?
  end

end
