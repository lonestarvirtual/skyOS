# frozen_string_literal: true

class Article < ApplicationRecord
  audited
  has_rich_text :content
end
