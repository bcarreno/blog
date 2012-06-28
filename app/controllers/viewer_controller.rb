class ViewerController < ApplicationController
  def pgp_key
  end

  def about
  end

  def sandbox
    authorize
  end
end
