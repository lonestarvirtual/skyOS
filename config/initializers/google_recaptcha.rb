# frozen_string_literal: true

module GoogleRecaptcha
  SITE_KEY = Rails.application.credentials.dig(
    :google_recaptcha,
    Rails.env.to_sym,
    :site_key
  )

  SECRET_KEY = Rails.application.credentials.dig(
    :google_recaptcha,
    Rails.env.to_sym,
    :site_key
  )

  # Returns true if GoogleAnalytics is enabled
  #
  def self.enabled?
    !SITE_KEY.nil? && !SECRET_KEY.nil?
  end
end
