# frozen_string_literal: true

module FlightsHelper
  def dest_airport_name(flight)
    flight.dest.present? ? flight.dest.name : nil
  end

  def origin_airport_name(flight)
    flight.orig.present? ? flight.orig.name : nil
  end

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
