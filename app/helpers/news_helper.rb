# frozen_string_literal: true

module NewsHelper
  def human_date(article)
    article.published_at.strftime('%B %d, %Y at %l:%M %p %Z')
  end
end
