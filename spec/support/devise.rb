# frozen_string_literal: true

require 'devise'
require_relative './controller_macros'

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.extend ControllerMacros, type: :request
end
