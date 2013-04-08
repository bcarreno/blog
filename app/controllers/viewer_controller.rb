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
    @videos = Video.order('created_at desc')
  end

end
