# frozen_string_literal: true

# Sets the SameSite policy on the session cookie in accordance with modern browser requirements.
Rails.application.config.session_store :cookie_store, same_site: :lax