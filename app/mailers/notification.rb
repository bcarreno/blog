class Notification < ActionMailer::Base

  def new_comment(comment)
    @comment = comment
    mail(:subject => 'New comment')
  end

  def new_message(message)
    @message = message
    mail(:subject => 'Contact through carreno.me')
  end
end
