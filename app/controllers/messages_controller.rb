class MessagesController < ApplicationController

  #REFACTOR ME
  #THE COMMENTS TOO!

  def create
    @message = Message.new(params[:message])
    saved = if params[:subject].present?
              logger.info "Honeypot Captcha Spam: #{params[:subject]}, #{params[:message].inspect}"
              true
            else
              @message.save
            end
    respond_to do |format|
      if saved
        format.html { redirect_to viewer_about_url, notice: "I'll get back to you as soon as I can, thanks." }
      else
        format.html { render 'viewer/about' }
      end
    end

    if params[:subject].blank? && saved
      Notification.new_message(@message).deliver
    end
  end
end
