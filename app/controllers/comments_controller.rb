class CommentsController < ApplicationController

  before_filter :authorize_admin, :except => [:create]
  before_filter :find_article_with_comments

  def edit
  end

  def create
    if !@article.comments_allowed
      render :nothing => true
    else
      spam = params.delete(:subject).present?
      @comment = @article.comments.new(comment_params)
      if !spam
        saved = @comment.save
      else
        saved = true
        logger.info "honeypot captcha spam comment: #{params[:comment].inspect}"
      end
      render :partial => saved ? 'comment' : 'form', :locals => {:article => @article, :comment => @comment}
      Notification.new_comment(@comment).deliver_now if saved && !spam
    end
  end

  def update
    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to(article_url(@comment.article), notice: 'Comment updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
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
    @article = Article.find_using_slug(params[:article_id])
    @comment = @article.comments.find(params[:id]) unless params[:id].nil?
  end

  def comment_params
    params.require(:comment).permit(:article_id, :body, :email, :name, :created_at)
  end
end
