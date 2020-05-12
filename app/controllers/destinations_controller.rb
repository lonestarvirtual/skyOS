# frozen_string_literal: true

class DestinationsController < ApplicationController
  skip_before_action :authenticate_pilot!
  skip_after_action  :verify_authorized

  def index
    @flights = Flight.select(:orig_id, :dest_id).distinct
    @flights = @flights.collect { |f| [f.orig.to_marker, f.dest.to_marker] }
  end
end
