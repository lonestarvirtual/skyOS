# frozen_string_literal: true

class Airline < ApplicationRecord
  include AttachedImage # concern

  extend FriendlyId
  friendly_id :icao

  after_validation :titleize_name, :upcase_iata, :upcase_icao

  has_many :fleets,  dependent: :restrict_with_error
  has_many :flights, dependent: :restrict_with_error
  has_many :pireps,  dependent: :restrict_with_error

  has_one_attached :logo
  alias image logo # for AttachedImage compatibility
  attribute :remove_logo, :boolean
  after_save :purge_image, if: :remove_logo
  validate :acceptable_image

  validates :icao, :name, presence: true, uniqueness: { case_sensitive: false }
  validates :icao, length: { maximum: 3 }
  validates :iata, length: { maximum: 2 }

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
end
