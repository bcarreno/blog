class MessagesController < ApplicationController

  def create
    spam = params.delete(:subject).present?
    @message = Message.new(params[:message])
    if !spam
      saved = @message.save
    else
      saved = true
      logger.info "honeypot captcha spam message: #{params[:message].inspect}"
    end

    respond_to do |format|
      if saved
        format.html { redirect_to viewer_about_url, notice: "I'll get back to you as soon as I can, thanks." }
      else
        format.html { render 'viewer/about' }
      end
    end

    Notification.new_message(@message).deliver if saved && !spam
  end
end
