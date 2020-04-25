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

  def permitted_attributes; end
end
