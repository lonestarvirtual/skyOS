# frozen_string_literal: true

# RailsSettings Model
class Setting < RailsSettings::Base
  field :admin_emails, default: 'admin@example.com', type: :array
  field :allow_signup, { default: 1, type: :boolean }
  field :copyright_name, { default: 'New Virtual Airline' }
  field :copyright_year, { default: Time.current.year, type: :integer }
  field :discord_link, { default: '' }
  field :discord_widget, { default: '' }
  field :google_analytics, { default: 0, type: :boolean }
  field :google_analytics_anonymous, { default: 0, type: :boolean }
  field :google_analytics_id, { default: '' }
  field :organization_icao, { default: 'ORG' }
  field :organization_name, { default: 'New Virtual Airline' }
  field :organization_tag_line, { default: "Today's premier virtual airline." }
  field :recaptcha_enabled, { default: 0, type: :boolean }
  field :recaptcha_min_score, { default: 0.5, type: :float }
  field :recaptcha_secret_key, { default: '' }
  field :recaptcha_site_key, { default: '' }
  field :reply_to, { default: 'configure_reply_to_setting@example.com' }
  field :starting_pid, { default: 100, type: :integer }
end
