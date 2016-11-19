class Notification < ActionMailer::Base
  mailer = YAML::load File.read(Rails.root + 'config/mailer.yml')
  default :from => mailer['user_name'], :to => mailer['user_name']

  def new_comment(comment)
    @comment = comment
    mail(:subject => 'New comment')
  end

  def new_message(message)
    @message = message
    mail(:subject => 'New message')
  end
end
