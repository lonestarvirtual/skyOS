# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(pilot: @user)
    end
  end

  def index?
    false
  end

  def create?
    false
  end

  def destroy?
    true
  end

  def update?
    true
  end
end
