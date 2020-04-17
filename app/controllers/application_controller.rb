# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  before_action :authenticate_pilot!
  after_action  :verify_authorized, unless: :devise_controller?
end
