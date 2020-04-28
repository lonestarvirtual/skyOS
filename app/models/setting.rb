# frozen_string_literal: true

# RailsSettings Model
class Setting < RailsSettings::Base
  field :admin_emails, default: 'admin@example.com', type: :array
  field :allow_signup, { default: 1, type: :boolean }
  field :organization_icao, { default: 'LSX' }
  field :recaptcha_min_score, { default: 0.5, type: :float }
end
