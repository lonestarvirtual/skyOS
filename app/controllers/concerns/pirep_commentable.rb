# frozen_string_literal: true

module PirepCommentable
  extend ActiveSupport::Concern

  private

  def comment_author(pirep)
    pirep.comments.each do |comment|
      next if comment.persisted?

      comment.author = current_pilot
    end
  end
end
