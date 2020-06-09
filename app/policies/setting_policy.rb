# frozen_string_literal: true

class SettingPolicy < ApplicationPolicy
  def index?
    true if @user.can?(Setting, :read)
  end

  def create?
    true if @user.can?(Setting, :update)
  end

  def destroy?
    false
  end

  def show?
    true if @user.can?(Setting, :read)
  end

  def update?
    true if @user.can?(Setting, :update)
  end

  def permitted_attributes
    %i[
      admin_emails allow_signup copyright_name copyright_year discord_link
      discord_widget google_analytics google_analytics_anonymous
      google_analytics_id organization_icao organization_name
      organization_tag_line recaptcha_enabled recaptcha_min_score
      recaptcha_secret_key recaptcha_site_key reply_to starting_pid
    ]
  end
end
