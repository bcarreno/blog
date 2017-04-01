require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test 'required attributes' do
    message = Message.new
    refute message.valid?
    assert_equal 'is invalid', message.errors[:email].first
    assert_equal "can't be blank", message.errors[:body].first

    message.email = 'dummy'
    refute message.valid?
    assert_equal 'is invalid', message.errors[:email].first
  end

  test 'create new message' do
    message = Message.new(email: 'stalker@example.com', body: 'Can we get together?')
    assert message.valid?, message.errors.full_messages.to_sentence
    assert_difference('Message.count', +1) do
      assert message.save!
    end
  end

end
