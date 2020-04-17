# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_pilot!
  skip_after_action  :verify_authorized

  def index; end
end
