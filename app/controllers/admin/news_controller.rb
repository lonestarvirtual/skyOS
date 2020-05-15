# frozen_string_literal: true

class Admin::NewsController < ApplicationController
  def index
    authorize Article, :index?
    @articles = Article.all.page params[:page]
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
      redirect_to admin_news_index_path
    else
      render :new
    end
  end
end
