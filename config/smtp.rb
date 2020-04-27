# frozen_string_literal: true

if Rails.env.production? && !ENV['RAILS_BUILD_IN_PROGRESS']
  SMTP_SETTINGS = {
    address: Rails.application.credentials.smtp[:address],
    authentication: :plain,
    domain: Rails.application.credentials.smtp[:domain],
    password: Rails.application.credentials.smtp[:password],
    port: '587',
    user_name: Rails.application.credentials.smtp[:username]
  }.freeze
elsif Rails.env.production?
  SMTP_SETTINGS = {}
end
