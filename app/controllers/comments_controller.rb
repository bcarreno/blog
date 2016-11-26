class CommentsController < ApplicationController

  before_filter :authorize_admin, :except => [:create]
  before_filter :find_article_with_comments

  def create
    logger.debug "zzz got to create, params: #{params}"
    if !@article.comments_allowed
      render :nothing => true
    else
      @comment = @article.comments.new(params[:comment])
      if params[:subject].blank?
        saved = @comment.save
      else
        saved = true
        logger.info "Honeypot Captcha Spam comment: #{params[:subject]}, #{params[:comment].inspect}"
      end
      render :partial => saved ? 'comment' : 'form', :locals => {:article => @article, :comment => @comment}
      Notification.new_comment(@comment).deliver if saved && params[:subject].blank?
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_url(@article, :anchor => 'comments') }
      format.json { head :no_content }
    end
  end

  private

  def find_article_with_comments
    logger.debug "zzz got to find_article_comment params #{params.inspect}"
    @article = Article.find_using_slug(params[:article_id])
    @comment = @article.comments.find(params[:id]) unless params[:id].nil?
  end

end
