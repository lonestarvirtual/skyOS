# frozen_string_literal: true

class Flight < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :airline,   optional: false
  belongs_to :equipment, optional: false
  belongs_to :orig, class_name: 'Airport'
  belongs_to :dest, class_name: 'Airport'

  before_validation :calculate_distance, :calculate_duration

  validates :number,
            :leg,
            :out_time,
            :in_time,
            :duration,
            :distance,
            presence: true

  validates :number,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 32_767
            },
            uniqueness: { scope: %i[airline_id leg] }

  validates :leg,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 127
            }

  validates :distance,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 32_767
            }

  validates :duration,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 99.9
            }

  validate :airline_operates_equipment

  def dest_icao
    dest.try(:icao)
  end

  def dest_icao=(icao)
    self.dest = Airport.find_by(icao: icao.upcase) if icao.present?
  end

  def in_time_local
    in_time.in_time_zone(dest.time_zone)
  end

  def normalize_friendly_id(string)
    super.upcase # ensure friendly id is always upcase
  end

  def orig_icao
    orig.try(:icao)
  end

  def orig_icao=(icao)
    self.orig = Airport.find_by(icao: icao.upcase) if icao.present?
  end

  # Return the out time in a timestamp local to the airport
  #
  def out_time_local
    out_time.in_time_zone(orig.time_zone)
  end

  def should_generate_new_friendly_id?
    return if airline.blank?

    airline_id_changed? || number_changed? || leg_changed? || super
  end

  private

  def airline_operates_equipment
    return if equipment.nil? || airline.nil?

    airline_list = equipment.fleets.joins(:airline).pluck(:airline_id)

    return if airline_list.include? airline.id

    errors.add(:equipment_id, 'not operated by airline (no fleet)')
  end

  def calculate_distance
    return if orig.nil? || dest.nil? || distance.present?

    self.distance = orig.distance_to(dest, :nm).round
  end

  # TODO: rubocop thinks this is too complex, refactor?
  def calculate_duration
    return if out_time.nil? || in_time.nil? || duration.present?

    in_time = self.in_time

    # if dept time is after arv time add 1 day (Rails/DB field difference)
    in_time += 1.day if out_time > in_time

    self.duration = ((in_time - out_time) / 1.hour).round(1)
  end

  def slug_candidates
    [
      ["#{airline.friendly_id}#{number}"],
      ["#{airline.friendly_id}#{number}-#{leg}"]
    ]
  end
end
