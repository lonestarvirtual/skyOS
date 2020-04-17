# frozen_string_literal: true

class FleetController < ApplicationController
  # rubocop:disable Rails/LexicallyScopedActionFilter
  skip_before_action :authenticate_pilot!, only: %i[index show]
  skip_after_action  :verify_authorized, only: %i[index show]
  # rubocop:enable Rails/LexicallyScopedActionFilter

  def index
    fleet = Fleet.joins(:airline).order('airlines.name', :name)
    @fleet = fleet.page(params[:page]).per(10)
  end
end
