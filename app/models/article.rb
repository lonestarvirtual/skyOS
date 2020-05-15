# frozen_string_literal: true

class Article < ApplicationRecord
  audited
  has_rich_text :content

  def updated_at
    audits.last.created_at
  end

  def created_at
    audits.first.created_at
  end

  def author
    audits.first.user
  end

  def editor
    audits.last.user
  end

  def edited?
    audits.last.user != audits.first.user
  end
end
