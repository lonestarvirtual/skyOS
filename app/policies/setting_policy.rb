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
      organization_icao organization_name recaptcha_min_score starting_pid
    ]
  end
end
