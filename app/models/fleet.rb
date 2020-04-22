# frozen_string_literal: true

class Fleet < ApplicationRecord
  attribute :remove_image, :boolean

  belongs_to :airline, optional: false
  belongs_to :equipment, optional: false

  has_many   :repaints, dependent: :destroy
  has_many   :flights,  through: :equipment, dependent: :restrict_with_error
  has_one_attached :image # fleet image max-size: 170x260

  after_save :purge_image, if: :remove_image

  validates :equipment_id, uniqueness: {
    scope: :airline_id,
    case_sensitive: false,
    message: 'already in use with this airline'
  }

  validate :acceptable_image

  accepts_nested_attributes_for :repaints,
                                allow_destroy: true,
                                reject_if: :all_blank

  private

  def acceptable_image
    return unless image.attached?

    errors.add(:image, 'is too big') unless image.byte_size <= 1.megabyte

    acceptable_types = %w[image/jpeg image/png]
    return if acceptable_types.include?(image.content_type)

    errors.add(:image, 'must be a JPEG or PNG')
  end

  # Delete the logo from storage
  #
  def purge_image
    image.purge_later
  end
end
