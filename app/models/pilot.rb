# frozen_string_literal: true

class Pilot < ApplicationRecord
  include Timezoneable
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  include Gravtastic
  gravtastic secure: true, filetype: :png, default: :identicon

  belongs_to :group, optional: false
  has_many   :permissions, through: :group
  has_many   :pireps, dependent: :destroy

  devise :confirmable, :database_authenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :trackable, :timeoutable, :validatable

  after_validation :titleize_name

  before_validation :assign_group, only: :create
  before_validation :assign_pid

  validates :pid,
            numericality: { only_integer: true },
            uniqueness: true,
            null: false

  validates :last_name,  presence: true, null: false
  validates :first_name, presence: true, null: false

  validate :valid_time_zone

  # Returns true or false whether Pilot has permission to perform
  # any supplied action on a model class
  #
  def can?(klass, *actions)
    actions.each do |action|
      if permissions.find_by(model: klass.to_s, action: action).present?
        return true
      end
    end
    false
  end

  # Return first and last name as string
  #
  def full_name
    "#{first_name} #{last_name}"
  end

  # Return the last approved PIREP
  #
  def last_flight
    approved_flights.order(date: :desc).first
  end

  # Format the Pilot ID into ICAO#
  #
  def pid_to_s
    "#{Setting.organization_icao}#{pid}"
  end

  def normalize_friendly_id(string)
    super.upcase # ensure friendly id is always upcase
  end

  def should_generate_new_friendly_id?
    pid_changed? || !persisted? || super
  end

  def to_s
    "#{full_name} (#{pid_to_s})"
  end

  # Return the total distance of approved flights
  #
  def total_distance
    approved_flights.sum(:distance)
  end

  # Return the total number of approved flights
  #
  def total_flights
    approved_flights.count
  end

  # Return the total hours of approved flights
  #
  def total_hours
    approved_flights.sum(:duration)
  end

  protected

  # Set the pilot's status to active after they have confirmed their
  # account (or after reconfirmations)
  #
  def after_confirmation
    # rubocop:disable Rails/SkipsModelValidations
    update_attribute(:active, true)
    # rubocop:enable Rails/SkipsModelValidations
  end

  private

  # Return records of approved flights
  #
  def approved_flights
    pireps.approved
  end

  # Assign the default Pilot group
  #
  def assign_group
    return unless group.nil?

    self.group = Group.find_by(name: 'Pilot')
  end

  # Assign the next available PilotID based on the last pilot and
  # the starting value
  #
  def assign_pid
    return unless pid.nil?

    start = Setting.starting_pid

    if Pilot.all.empty?
      self.pid = start
    else
      last = Pilot.order(pid: :desc).first
      self.pid = (last.pid >= start ? last.pid + 1 : start)
    end
  end

  def slug_candidates
    # slug_candidates seems to get called prior to assign_pid on creation
    assign_pid if pid.nil?

    [
      ["#{Setting.organization_icao.upcase}#{pid}"]
    ]
  end

  # Titleize name
  #
  def titleize_name
    return if first_name.nil? || last_name.nil?

    self.first_name = first_name.titleize
    self.last_name  = last_name.titleize
  end
end
