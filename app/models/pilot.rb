# frozen_string_literal: true

class Pilot < ApplicationRecord
  belongs_to :group, optional: false
  has_many   :permissions, through: :group

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

  # Returns true or false whether Pilot has permission to perform
  # an action on a model class
  #
  def can?(klass, action)
    permissions.find_by(model: klass.to_s, action: action).present?
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

    start = 100

    if Pilot.all.empty?
      self.pid = start
    else
      last = Pilot.order(pid: :desc).first
      self.pid = (last.pid >= start ? last.pid + 1 : start)
    end
  end

  # Titleize name
  #
  def titleize_name
    return if first_name.nil? || last_name.nil?

    self.first_name = first_name.titleize
    self.last_name  = last_name.titleize
  end
end
