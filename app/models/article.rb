# frozen_string_literal: true

class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_paper_trail ignore: %i[created_at updated_at author editor]
  has_rich_text :content

  validates :title, presence: true
  # Force published true
  attribute :published, :boolean, default: true

  alias_attribute :edited_at, :updated_at
  alias_attribute :published_at, :created_at

  belongs_to :author, optional: true, class_name: 'Pilot'
  belongs_to :editor, optional: true, class_name: 'Pilot'

  def edited?
    !versions.empty?
  end

  def slug_candidates
    slug_date = DateTime.now.strftime('%Y-%m-%d-%H%M')
    [
      "#{slug_date}-#{title}"
    ]
  end
end
