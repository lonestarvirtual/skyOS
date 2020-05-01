# frozen_string_literal: true

class Airport < ApplicationRecord
  include Timezoneable
  extend FriendlyId
  friendly_id :icao
  reverse_geocoded_by :latitude, :longitude

  has_many :flight_origins,
           class_name: 'Flight',
           foreign_key: :orig_id,
           inverse_of: :orig,
           dependent: :restrict_with_error

  has_many :flight_destinations,
           class_name: 'Flight',
           foreign_key: :dest_id,
           inverse_of: :dest,
           dependent: :restrict_with_error

  has_many :pirep_origins,
           class_name: 'Pirep',
           foreign_key: :orig_id,
           inverse_of: :orig,
           dependent: :restrict_with_error

  has_many :pirep_destinations,
           class_name: 'Pirep',
           foreign_key: :dest_id,
           inverse_of: :dest,
           dependent: :restrict_with_error

  validates :icao, :name, :city, presence: true
  validates :icao, length: { maximum: 4 }
  validates :iata, length: { maximum: 3 }

  validates :icao, uniqueness: { case_sensitive: false }

  validates :latitude, numericality: {
    less_than_or_equal_to: 90,
    greater_than_or_equal_to: -90
  }

  validates :longitude, numericality: {
    less_than_or_equal_to: 180,
    greater_than_or_equal_to: -180
  }

  validate :valid_time_zone

  before_validation :set_time_zone, :upcase_iata, :upcase_icao

  default_scope { order(:city) }

  def to_s
    "#{city} (#{icao})"
  end

  private

  # Sets the timezone from latitude/longitude if blank
  #
  def set_time_zone
    return if time_zone.present?

    tz = TimezoneFinder.create
    tz = tz.certain_timezone_at(lat: latitude, lng: longitude)
    self.time_zone = tz.to_s
  end

  # Upcase IATA
  #
  def upcase_iata
    return if iata.nil?

    self.iata = iata.upcase
  end

  # Upcase ICAO
  #
  def upcase_icao
    return if icao.nil?

    self.icao = icao.upcase
  end
end
