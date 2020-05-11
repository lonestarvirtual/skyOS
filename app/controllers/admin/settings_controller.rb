# frozen_string_literal: true

module Admin
  class SettingsController < ApplicationController
    # before_action :get_setting, only: [:edit, :update]

    def index
      authorize Setting, :index?
    end

    def create
      authorize Setting, :update?

      setting_params = permitted_attributes(Setting)

      setting_params.each_key do |key|
        next if setting_params[key].nil?

        Setting.send("#{key}=", setting_params[key].strip)
      end
      redirect_to admin_settings_path, alert: 'Settings updated'
    end
  end
end
