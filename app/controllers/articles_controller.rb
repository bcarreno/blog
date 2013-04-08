class ArticlesController < ApplicationController

  before_filter :authorize_admin, :except => [:index, :show]
  before_filter :find_article, :only => [:show, :edit, :update, :destroy]

  def index
    @articles = Article.visibles(current_user).order('created_at desc').page params[:page]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  def show
    if @article.nil?
      redirect_to articles_url, :notice => 'Article not found'
    else

    end
  end

  def new
    @article = Article.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  def edit
    if @article.nil?
      redirect_to articles_url, :notice => 'Article not found'
    else

    end
  end

  def create
    @article = Article.new(params[:article])
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @article.nil?
      redirect_to articles_url, :notice => 'Article not found'
    elsif @article.update_attributes(params[:article])
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @article.destroy if @article
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private

  def find_article
    begin
      @article = Article.visibles(current_user).find_using_slug(params[:id])
    rescue
      @article = nil
    end
  end

end
