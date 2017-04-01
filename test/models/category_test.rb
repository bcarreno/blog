require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test 'required attributes' do
    category = Category.new
    refute category.valid?
    [:name].each do |field|
      assert_equal "can't be blank", category.errors[field].first
    end
  end

  test 'create new category' do
    category = Category.new(name: 'Horror', description: 'Fear & Horror')
    assert category.valid?
    assert_difference('Category.count') do
      assert category.save!
    end
  end

end
