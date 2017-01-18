require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  test 'post create' do
    assert_difference ['Message.count', 'ActionMailer::Base.deliveries.size'], +1 do
      post :create, message: { body: 'This is the body', email: 'test@example.com' }
    end
    assert_redirected_to viewer_about_path
    assert_equal "I'll get back to you as soon as I can, thanks.", flash[:notice]

    message_email = ActionMailer::Base.deliveries.last
    assert_equal 'New message',        message_email.subject
    assert_equal 'braulio@carreno.me', message_email.to[0]
    assert_equal 'braulio@carreno.me', message_email.from[0]
    assert_match(/test@example.com/,   message_email.body.to_s)
    assert_match(/This is the body/,   message_email.body.to_s)
  end

  test 'post create insufficient params' do
    assert_difference ['Message.count', 'ActionMailer::Base.deliveries.size'], 0 do
      post :create, message: { email: 'test@example.com' }
    end
    assert_response :success
    assert_match /can't be blank/, assigns(:message).errors[:body].to_s
  end

  test 'honeypot captcha spam' do
    assert_difference ['Message.count', 'ActionMailer::Base.deliveries.size'], 0 do
      post :create, subject: 'viagra on sale',
                    message: { body: 'This is the body', email: 'test@example.com' }
    end
    assert_redirected_to viewer_about_path
    assert_equal "I'll get back to you as soon as I can, thanks.", flash[:notice]
  end

end
