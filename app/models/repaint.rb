# frozen_string_literal: true

class Repaint < ApplicationRecord
  belongs_to :fleet
  has_one_attached :file

  validates :fleet, :name, :file, presence: true

  validate :acceptable_file

  default_scope { order :name }

  private

  def acceptable_file
    return unless file.attached?

    errors.add(:file, 'is too big') unless file.byte_size <= 100.megabyte
  end
end
