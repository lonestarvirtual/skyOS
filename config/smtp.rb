# frozen_string_literal: true

if Rails.env.production? && !ENV['RAILS_BUILD_IN_PROGRESS']
  SMTP_SETTINGS = {
    address: ENV['SMTP_SERVER'],
    domain: ENV['SMTP_DOMAIN'] || ENV['RAILS_HOSTNAME'],
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD'],
    authentication: ENV['SMTP_AUTH'] || :plain,
    port: ENV['SMTP_PORT'] || 25
  }.freeze
elsif Rails.env.production?
  SMTP_SETTINGS = {}.freeze
end
