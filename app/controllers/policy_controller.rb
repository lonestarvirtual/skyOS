# frozen_string_literal: true

class PolicyController < ApplicationController
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
