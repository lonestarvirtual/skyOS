# frozen_string_literal: true

class NewsController < ApplicationController
  skip_before_action :authenticate_pilot!, only: %i[index]

  def index
    authorize Article, :index?

    # Forgive me Matz, for I have sinned.
    @q = policy_scope(Article).friendly.includes(:versions)
                               .joins(:versions)
                               .where(versions: { event: :create })
                               .with_rich_text_content
                               .order('versions.created_at DESC')
    @articles = @q.page(params[:page]).per(10)
  end
end
