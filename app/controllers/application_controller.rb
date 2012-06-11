class ApplicationController < ActionController::Base

  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def admin?
    false
  end
  helper_method :admin?

  def home_page?
    params[:controller] == 'articles' && params[:action] == 'index'
  end
  helper_method :home_page?

end
