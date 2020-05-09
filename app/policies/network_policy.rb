# frozen_string_literal: true

class NetworkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.can?(Network, :read)
  end

  def create?
    @user.can?(Network, :create)
  end

  def destroy?
    @user.can?(Network, :destroy)
  end

  def update?
    @user.can?(Network, :update)
  end

  def permitted_attributes
    [:name] if @user.can?(Fleet, :create) || @user.can?(Fleet, :update)
  end
end
