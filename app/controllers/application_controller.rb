# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  before_action :authenticate_pilot!, unless: :exception_controller?
  after_action  :verify_authorized, unless: :skip_authorization?

  private

  # Return true if it's an exception_controller. false to all other controllers.
  # This allows custom error pages to work in production without having verify
  # a member is logged in or authorized to view the page
  #
  def exception_controller?
    is_a?(ExceptionHandler::ExceptionsController)
  end

  # Returns true if Pundit authorization should be skipped.
  #
  def skip_authorization?
    devise_controller? || exception_controller?
  end
end
