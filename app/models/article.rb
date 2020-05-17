# frozen_string_literal: true

class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_paper_trail
  has_rich_text :content

  validates :title, presence: true
  # Force published true
  attribute :published, :boolean, default: true

  def edited_at
    versions.last.created_at
  end

  def published_at
    versions.first.created_at
  end

  def author
    versions.first.version_author
  end

  def editor
    paper_trail.originator
  end

  def edited?
    !versions.empty?
  end
end