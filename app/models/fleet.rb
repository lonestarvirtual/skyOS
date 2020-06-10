# frozen_string_literal: true

class Fleet < ApplicationRecord
  include AttachedImage # concern

  belongs_to :airline, optional: false
  belongs_to :equipment, optional: false

  has_many   :repaints, dependent: :destroy
  has_many   :flights,  through: :equipment, dependent: :restrict_with_error

  has_one_attached :image # fleet image max-size: 170x260
  attribute :remove_image, :boolean
  after_save :purge_image, if: :remove_image
  validate :acceptable_image

  validates :equipment_id, uniqueness: {
    scope: :airline_id,
    case_sensitive: false,
    message: 'already in use with this airline'
  }

  accepts_nested_attributes_for :repaints,
                                allow_destroy: true,
                                reject_if: :all_blank

  delegate :short_name, to: :equipment
  delegate :icao, to: :equipment
  delegate :name, to: :equipment
end
