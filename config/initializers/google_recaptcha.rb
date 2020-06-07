# frozen_string_literal: true

module GoogleRecaptcha
  # Returns true if GoogleAnalytics is enabled
  #
  def self.enabled?
    return unless Setting.recaptcha_enabled?

    site_key.present? && secret_key.present?
  end

  def self.minimum_score
    # FIXME: remove to_f when rails_settings_cached supports float casting
    Setting.recaptcha_min_score.to_f
  end

  def self.secret_key
    Setting.recaptcha_secret_key
  end

  def self.site_key
    Setting.recaptcha_site_key
  end
end
