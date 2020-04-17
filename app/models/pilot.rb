# frozen_string_literal: true

class Pilot < ApplicationRecord
  belongs_to :group, required: true

  devise :confirmable, :database_authenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :trackable, :timeoutable, :validatable

  before_validation :assign_group, only: :create
  before_validation :assign_pid

  validates :pid,
            numericality: { only_integer: true },
            uniqueness: true,
            null: false

  validates :last_name,  presence: true, null: false
  validates :first_name, presence: true, null: false

  protected

  # Set the pilot's status to active after they have confirmed their
  # account (or after reconfirmations)
  #
  def after_confirmation
    self.update_attribute(:active, true)
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
end
