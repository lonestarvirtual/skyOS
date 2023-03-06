# frozen_string_literal: true

if Rails.env.production? && !ENV['RAILS_BUILD_IN_PROGRESS']
  SMTP_SETTINGS = {
    address: ENV.fetch('SMTP_SERVER', nil),
    domain: ENV['SMTP_DOMAIN'] || ENV.fetch('RAILS_HOSTNAME', nil),
    user_name: ENV.fetch('SMTP_USERNAME', nil),
    password: ENV.fetch('SMTP_PASSWORD', nil),
    authentication: ENV['SMTP_AUTH'] || :plain,
    port: ENV['SMTP_PORT'] || 25
  }.freeze
elsif Rails.env.production?
  SMTP_SETTINGS = {}.freeze
end
