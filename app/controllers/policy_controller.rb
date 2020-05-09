# frozen_string_literal: true

class PolicyController < ApplicationController
  skip_before_action  :authenticate_pilot!
  skip_after_action   :verify_authorized

  def show
    case params[:id]
    when 'privacy'
      render 'privacy'
    when 'terms'
      render 'terms'
    else
      raise ActionController::RoutingError, 'Not Found'
    end
  end
end
