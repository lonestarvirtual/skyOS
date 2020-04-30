# frozen_string_literal: true

module Api
  module V1
    class AirportsController < ApplicationController
      skip_after_action :verify_authorized, only: :show

      def show
        @airport = Airport.find_by(icao: params[:id].upcase)
        render json: @airport
      end
    end
  end
end
