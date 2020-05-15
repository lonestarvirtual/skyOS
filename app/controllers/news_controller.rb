# frozen_string_literal: true

class NewsController < ApplicationController
  skip_before_action :authenticate_pilot!, only: %i[index]
  skip_after_action  :verify_authorized, only: %i[index]

  def index
    # FIXME: Deal with anonymous user access in pundit.
    # authorize Article, :index?
    @q = Article.ransack(params[:q])
    @articles = @q.result.page(params[:page])
  end
end
