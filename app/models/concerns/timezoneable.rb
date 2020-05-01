# frozen_string_literal: true

module Timezoneable
  include ActiveSupport::Concern

  def valid_time_zone
    if time_zone.present?
      return if ActiveSupport::TimeZone.new(time_zone).present?

      errors.add(:time_zone, 'must be valid')
    else
      errors.add(:time_zone, "can't be blank")
    end
  end
end
