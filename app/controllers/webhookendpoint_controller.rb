class WebhookendpointController < ApplicationController

  def create
    logger.error "zzz webhookendpoint params #{params.inspect}" 

    respond_to do |format|
      format.html { render plain: 'webhookendpoint hit' }
      format.json { render json:  'webhookendpoint hit' }
    end
  end
end
