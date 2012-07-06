class Notification < ActionMailer::Base
  default from: ENV['GMAIL_USER']

  def new_message(message)
    @message = message
    mail(:to => ENV['GMAIL_USER'], 'New message')
  end
end
