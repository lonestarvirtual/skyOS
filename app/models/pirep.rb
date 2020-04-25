# frozen_string_literal: true

class Pirep < ApplicationRecord
  belongs_to :pilot, optional: false
  belongs_to :airline, optional: false
  belongs_to :orig, class_name: 'Airport', optional: false
  belongs_to :dest, class_name: 'Airport', optional: false
  belongs_to :equipment, optional: false
  belongs_to :simulator, optional: false
  belongs_to :network, optional: true
  belongs_to :status, class_name: 'PirepStatus', optional: false

  has_many :comments, class_name: 'PirepComment', dependent: :destroy

  accepts_nested_attributes_for :comments,
                                allow_destroy: true,
                                reject_if: :all_blank

  before_validation :calculate_distance, :upcase_route
  before_validation :set_status, on: :create

  validates :pilot,
            :date,
            :airline_id,
            :flight,
            :leg,
            :orig_id,
            :dest_id,
            :route,
            :equipment_id,
            :simulator_id,
            :duration,
            :distance,
            :status_id,
            presence: true

  validates :flight,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 32_767
            }

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

  scope :approved, -> { joins(:status).where('pirep_statuses.approved': true) }

  def dest_icao
    dest.try(:icao)
  end

  def dest_icao=(icao)
    self.dest = Airport.find_by(icao: icao.upcase) if icao.present?
  end

  # TODO: - find a better way to handle checkbox draft status in
  #        user editable PIREPs
  #
  def draft=(flag)
    self.status = if flag.to_s == '1'
                    PirepStatus.find_by(name: 'Draft')
                  else
                    PirepStatus.find_by(name: 'Submitted')
                  end
  end

  def draft
    return false if status.blank?

    status.editable?
  end

  def orig_icao
    orig.try(:icao)
  end

  def orig_icao=(icao)
    self.orig = Airport.find_by(icao: icao.upcase) if icao.present?
  end

  def to_s
    "#{airline.icao}#{flight} Leg #{leg}"
  end

  private

  def calculate_distance
    return if orig.nil? || dest.nil? || distance.present?

    self.distance = orig.distance_to(dest, :nm).round
  end

  def set_status
    return unless status.nil?

    self.status = PirepStatus.find_by(name: 'Submitted')
  end

  def upcase_route
    self.route = route.upcase unless route.nil?
  end
end
