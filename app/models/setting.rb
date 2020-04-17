# frozen_string_literal: true

# RailsSettings Model
class Setting < RailsSettings::Base
  field :admin_emails, default: 'admin@example.com', type: :array
  field :recaptcha_min_score, { default: 0.5, type: :float }
  field :reply_to, { type: :string, default: 'noreply@example.com' }
end
