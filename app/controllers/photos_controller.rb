# XXX if we control access to static images using a middleware we
# can remove this controller and just use the 'photos' action
# under the viewer controller
class PhotosController < ApplicationController

  before_filter :authorize

  def index
  end

  def show
    if full_filename = full_private_filename("#{params[:base]}.#{params[:format]}")
      send_file full_filename, disposition: 'inline'
    end
  end
end
