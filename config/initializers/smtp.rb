# frozen_string_literal: true

if Rails.env.production?
  SMTP_SETTINGS = {
    address: Rails.application.credentials.smtp[:address],
    authentication: :plain,
    domain: Rails.application.credentials.smtp[:domain],
    password: Rails.application.credentials.smtp[:password],
    port: '587',
    user_name: Rails.application.credentials.smtp[:username]
  }.freeze
end
