# frozen_string_literal: true

class NewsController < ApplicationController
  skip_before_action :authenticate_pilot!, only: %i[index]

  def index
    authorize Article, :index?

    # Forgive me Matz, for I have sinned.
    query = policy_scope(Article).friendly
                                 .with_rich_text_content
                                 .order('articles.created_at DESC')
    @articles = query.page(params[:page]).per(10)
  end

  def show
    authorize Article, :show?
    @article = policy_scope(Article).friendly.find(params[:id])
  end
end
