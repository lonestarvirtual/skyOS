# frozen_string_literal: true

# RailsSettings Model
class Setting < RailsSettings::Base
  field :admin_emails, default: 'admin@example.com', type: :array
  field :allow_signup, { default: 1, type: :boolean }
  field :copyright_name, { default: 'Lonestar Virtual' }
  field :copyright_year, { default: 2018, type: :integer }
  field :discord_link, { default: 'https://discord.gg/BjTXJPv' }
  field :organization_icao, { default: 'LSX' }
  field :organization_name, { default: 'Lonestar Cargo' }
  field :recaptcha_min_score, { default: 0.5, type: :float }
  field :starting_pid, { default: 100, type: :integer }
end
