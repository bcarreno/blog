class ApplicationController < ActionController::Base

  include ::SslRequirement
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to login_url, :notice => 'Login required' if current_user.nil?
  end

  def authorize_admin
    authorize
    redirect_to root_url if current_user && !admin?
  end

  def admin?
    current_user && current_user.admin
  end
  helper_method :admin?

  def production?
    !['test', 'development'].include?(Rails.env)
  end

#  def home_page?
#    params[:controller] == 'articles' && params[:action] == 'index'
#  end
#  helper_method :home_page?

end
