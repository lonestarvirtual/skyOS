# frozen_string_literal: true

class Announcement < ApplicationRecord
  validates :title, :body, :start_at, :end_at, presence: true
  validate :ends_in_the_future, :starts_before_end_time

  # Grab whatever announcement should be displayed right now
  #
  def self.now
    where('start_at <= ?', Time.current) \
      .where('end_at >= ?', Time.current) \
      .order(start_at: :desc).first
  end

  # Purge any announcements that have an end date earlier than now
  #
  def self.purge
    where('end_at <= ?', Time.current).destroy_all
  end

  private

  # Validates the end_at time is in the future
  # (otherwise what is the point of adding it when it would never display)
  #
  def ends_in_the_future
    return unless end_at.present? && Time.current > end_at

    errors.add(:end_at, 'must be in the future')
  end

  # Validates the start_at time is before the end_at time
  # (otherwise it would never appear)
  #
  def starts_before_end_time
    return unless start_at.present? && end_at.present? && start_at > end_at

    errors.add(:start_at, 'must be before end_at')
  end
end
