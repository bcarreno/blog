class ViewerController < ApplicationController

  def about
  end

  def pgp_key
  end

  def sandbox
    authorize_admin
  end

  def videos
    authorize
  end

end
