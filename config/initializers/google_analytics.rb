# frozen_string_literal: true

module GoogleAnalytics
  TRACKING_ID = Rails.application.credentials.dig(
    :google_analytics,
    :tracking_id
  )

  JS_URL = "https://www.googletagmanager.com/gtag/js?id=#{TRACKING_ID}"

  # Returns true if GoogleAnalytics is enabled
  #
  def self.enabled?
    !TRACKING_ID.nil?
  end
end
