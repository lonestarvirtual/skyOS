# frozen_string_literal: true

class Simulator < ApplicationRecord
  validates :short_name, length: { maximum: 15 }

  validates :name,
            :short_name,
            presence: true,
            uniqueness: { case_sensitive: false }
end
