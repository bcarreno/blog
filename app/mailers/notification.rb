class Notification < ActionMailer::Base
  default :from => ActionMailer::Base.smtp_settings[:user_name], :to => ActionMailer::Base.smtp_settings[:user_name]

  def new_comment(comment)
    @comment = comment
    mail(:subject => 'New comment')
  end

  def new_message(message)
    @message = message
    mail(:subject => 'New message')
  end
end
