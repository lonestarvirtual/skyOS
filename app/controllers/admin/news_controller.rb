# frozen_string_literal: true

module Admin
  class NewsController < ApplicationController
    def index
      authorize Article, :index?

      @q = policy_scope(Article).friendly.includes(:versions)
               .joins(:versions)
               .where(versions: { event: :create })
               .with_rich_text_content
               .order('versions.created_at DESC')

      @articles = @q.page params[:page]
    end

    def new
      authorize Article, :new?
      @article = Article.new
    end

    def create
      authorize Article, :create?
      @article = Article.new(permitted_attributes(Article))

      if @article.save
        flash[:success] = 'Article Published'
        redirect_to admin_articles_path
      else
        render :new
      end
    end

    def destroy
      @article = Article.friendly.find(params[:id])
      authorize @article, :destroy?

      if @article.destroy
        flash[:success] = "#{@article.title} deleted"
        redirect_to admin_articles_path
      else
        flash[:danger] = 'Unable to delete article'
        render :edit
      end
    end

    def edit
      @article = Article.friendly.find(params[:id])
      authorize @article, :edit?
    end

    def update
      @article = Article.friendly.find(params[:id])
      authorize @article, :update?

      if @article.update(permitted_attributes(@article))
        flash[:success] = 'Article updated'
        redirect_to admin_articles_path
      else
        render :edit
      end
    end
  end
end