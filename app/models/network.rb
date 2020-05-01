# frozen_string_literal: true

class Network < ApplicationRecord
  has_many :pireps, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  default_scope { order(:name) }

  def to_s
    name
  end
end
