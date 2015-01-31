require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user_attributes = {username: 'test', email: 'test@test.com', password: 'test', name: 'John Test'}
    @user_attributes[:password_confirmation] = @user_attributes[:password]
  end

  test 'required attributes' do
    user = User.new
    refute user.valid?
    [:username, :email, :name].each do |field|
      assert_equal "can't be blank", user.errors[field].first
    end
  end

  test 'create new user' do
    user = User.new(@user_attributes)
    assert user.valid?
    assert_difference('User.count') do
      assert user.save
    end
    assert user.password_digest.strip.size >= 60
  end

  test 'do not duplicate username' do
    user = User.new(@user_attributes.merge(username: users(:regular).username))
    refute user.valid?
  end

  test 'confirmation matches password' do
    user = User.new(@user_attributes.merge(password_confirmation: 'different'))
    refute user.valid?
    assert_equal "doesn't match confirmation", user.errors[:password].first
  end

  test 'digests should be different for the same password' do
    user1 = User.create!(@user_attributes)
    user2 = User.create!(@user_attributes.merge(username: 'test2'))
    refute_equal user1.password_digest.to_s, user2.password_digest.to_s
  end

end
