class UsersController < ApplicationController

  before_filter :authorize_admin
  ssl_exceptions if production?

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "User created."
    else
      render "new"
    end
  end
end
