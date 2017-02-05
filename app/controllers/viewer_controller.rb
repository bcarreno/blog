class ViewerController < ApplicationController

  def about
  end

  def pgp_key
  end

  def videos
    authorize
    @videos = Video.order('created_at desc').page params[:page]
  end

end
