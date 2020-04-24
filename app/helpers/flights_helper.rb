# frozen_string_literal: true

module FlightsHelper
  # Returns a unique collection of Airport objects
  # that are scheduled destinations
  #
  def unique_destinations
    Airport.joins(:flight_destinations).uniq
  end

  # Returns a unique collection of Airport objects
  # that are scheduled origins
  #
  def unique_origins
    Airport.joins(:flight_origins).uniq
  end
end
