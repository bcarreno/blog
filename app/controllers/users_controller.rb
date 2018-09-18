class UsersController < ApplicationController

  before_action :authorize_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, :notice => "User created."
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :name, :password, :password_confirmation)
  end
end
