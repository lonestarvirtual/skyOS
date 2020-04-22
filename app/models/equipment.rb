# frozen_string_literal: true

class Equipment < ApplicationRecord
  extend FriendlyId
  friendly_id :short_name

  has_many :fleets, dependent: :restrict_with_error

  validates :icao, :name, :short_name, presence: true

  validates :short_name,
            format: { without: /\s/ },
            uniqueness: { case_sensitive: false }

  validates :icao, length: { maximum: 4 }, format: { without: /\s/ }
  validates :iata, length: { maximum: 3 }, format: { without: /\s/ }

  before_validation :upcase_iata, :upcase_icao, :upcase_short_name

  default_scope { order(:short_name) }

  private

  def upcase_iata
    return if iata.blank?

    self.iata = iata.upcase
  end

  def upcase_icao
    return if icao.blank?

    self.icao = icao.upcase
  end

  def upcase_short_name
    return if short_name.blank?

    self.short_name = short_name.upcase
  end
end
