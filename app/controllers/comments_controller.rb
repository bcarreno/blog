class CommentsController < ApplicationController

  before_filter :authorize_admin, :except => [:create]
  before_filter :find_article_comment

  def index
    @comments = @article.comments
    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  def new
    @comment = @article.comments.new
    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  def edit
  end

  def create
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

  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(article_url(@comment.article_id), notice: 'Comment updated') }
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

  def find_article_comment
    @article = Article.find_using_slug(params[:article_id])
    @comment = @article.comments.find(params[:id]) unless params[:id].nil?
  end

end
