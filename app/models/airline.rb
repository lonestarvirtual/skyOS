# frozen_string_literal: true

class Airline < ApplicationRecord
  extend FriendlyId
  friendly_id :icao

  attribute :remove_logo, :boolean

  has_many :fleets,  dependent: :restrict_with_error
  has_many :flights, dependent: :restrict_with_error
  has_many :pireps,  dependent: :restrict_with_error
  has_one_attached :logo

  after_save :purge_logo, if: :remove_logo
  after_validation :titleize_name, :upcase_iata, :upcase_icao

  # TODO: - is this necessary or will ActiveStorage do it automagically?
  before_destroy :purge_logo

  validates :icao, :name, presence: true, uniqueness: { case_sensitive: false }
  validates :icao, length: { maximum: 3 }
  validates :iata, length: { maximum: 2 }

  validate :acceptable_logo

  default_scope { order(:name) }

  private

  def titleize_name
    return if name.nil?

    self.name = name.titleize
  end

  def upcase_iata
    return if iata.nil?

    self.iata = iata.upcase
  end

  def upcase_icao
    return if icao.nil?

    self.icao = icao.upcase
  end

  # Ensure the logo is acceptable
  #
  def acceptable_logo
    return unless logo.attached?

    errors.add(:logo, 'is too big') unless logo.byte_size <= 1.megabyte

    acceptable_types = %w[image/jpeg image/png]
    return if acceptable_types.include?(logo.content_type)

    errors.add(:logo, 'must be a JPEG or PNG')
  end

  # Delete the logo from storage
  #
  def purge_logo
    logo.purge_later
  end
end
