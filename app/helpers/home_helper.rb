# frozen_string_literal: true

module HomeHelper
  def membership_statistics
    stats = {}
    stats[:routes]        = Flight.all.count
    stats[:pilots]        = Pilot.where(active: true).count
    stats[:total_flights] = Pirep.approved.count
    stats[:total_hours]   = Pirep.approved.sum(:duration)
    stats
  end
end
