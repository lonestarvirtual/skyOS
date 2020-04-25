# frozen_string_literal: true

module PilotsHelper
  def pilot_last_flight(pilot)
    return 'Never' if pilot.last_flight.blank?

    pilot.last_flight.date.strftime('%m-%d-%Y')
  end
end
