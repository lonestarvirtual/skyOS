# frozen_string_literal: true

class PilotPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(active: true)
    end
  end

  def index?
    @user.can?(Pilot, :read)
  end

  def create?
    @user.can?(Pilot, :create)
  end

  def destroy?
    @user.can?(Pilot, :destroy)
  end

  def update?
    @user.can?(Pilot, :update)
  end

  # Profile actions
  #
  def profile_show?
    true if @record == @user
  end

  def profile_update?
    true if @record == @user
  end

  def permitted_attributes
    return unless @user.can?(Pilot, :update)

    %i[pid active first_name last_name email password
       password_confirmation time_zone group_id]
  end
end
