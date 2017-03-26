class ApplicationController < ActionController::Base

  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound,         :with => :render_404
  rescue_from ActionController::MissingFile,        :with => :render_404

  private

  def render_404
    render "system/error_404", status: 404, layout: 'application', formats: [:html]
  end

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

  def self.production?
    !['test', 'development'].include?(Rails.env)
  end

  def full_private_filename(filename)
    full_filename = File.expand_path(filename, PRIVATE_ASSETS_PATH)
    if File.join(PRIVATE_ASSETS_PATH, filename) == full_filename
      full_filename
    else
      raise ActionController::MissingFile
    end
  end

#  def home_page?
#    params[:controller] == 'articles' && params[:action] == 'index'
#  end
#  helper_method :home_page?

end
