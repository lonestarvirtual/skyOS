# frozen_string_literal: true

class Simulator < ApplicationRecord
  has_many :pireps, dependent: :restrict_with_error

  validates :short_name, length: { maximum: 15 }

  validates :name,
            :short_name,
            presence: true,
            uniqueness: { case_sensitive: false }

  default_scope { order(:name) }
end
