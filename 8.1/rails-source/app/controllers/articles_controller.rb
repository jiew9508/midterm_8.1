class ArticlesController < ApplicationController
  http_basic_authenticate_with name: ENV.fetch("BLOG_ADMIN_USER", "admin"),
    password: ENV.fetch("BLOG_ADMIN_PASSWORD"), except: [:index, :show]

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.includes(:comments).order(created_at: :desc)
    @query = params[:q].to_s.strip.first(100)
    if @query.present?
      pattern = "%#{ActiveRecord::Base.sanitize_sql_like(@query.downcase)}%"
      @articles = @articles.where("LOWER(title) LIKE :q OR LOWER(body) LIKE :q", q: pattern)
    end
    @selected_topic = params[:topic].presence
    if Article::TOPICS.include?(@selected_topic)
      @articles = @articles.where(topic: @selected_topic)
    end
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "Article published."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Changes saved."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy!
    redirect_to articles_path, status: :see_other, notice: "Article deleted."
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :topic)
  end
end
