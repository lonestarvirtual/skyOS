# frozen_string_literal: true

class PirepStatus < ApplicationRecord
  has_many :pireps,
           foreign_key: :status_id,
           inverse_of: :status,
           dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  default_scope { order(:sequence) }

  def to_s
    name
  end
end
