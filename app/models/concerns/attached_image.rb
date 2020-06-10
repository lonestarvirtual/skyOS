# frozen_string_literal: true

module AttachedImage
  extend ActiveSupport::Concern

  private

  # Validates the image is acceptable
  #
  def acceptable_image
    return unless image.attached?

    errors.add(:image, 'is too big') unless image.byte_size <= 1.megabyte

    acceptable_types = %w[image/jpeg image/png]
    return if acceptable_types.include?(image.content_type)

    errors.add(:image, 'must be a JPEG or PNG')
  end

  # Delete the image from storage
  #
  def purge_image
    image.purge_later
  end
end
