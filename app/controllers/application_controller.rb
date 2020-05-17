# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  around_action :use_time_zone, if: :current_pilot
  before_action :authenticate_pilot!, unless: :exception_controller?
  before_action :set_paper_trail_whodunnit
  after_action  :verify_authorized, unless: :skip_authorization?

  private

  # Return true if it's an exception_controller. false to all other controllers
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

  # Override pundit user lookup to use Pilot model
  #
  def pundit_user
    current_pilot
  end

  def user_for_paper_trail
    current_pilot
  end

  def use_time_zone(&block)
    Time.use_zone(current_pilot.time_zone, &block)
  end

  def after_sign_in_path_for(_resource)
    articles_path
  end
end
