# frozen_string_literal: true

class SimulatorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.can?(Simulator, :create)
  end

  def create?
    @user.can?(Simulator, :create)
  end

  def destroy?
    @user.can?(Simulator, :destroy)
  end

  def update?
    @user.can?(Simulator, :update)
  end

  def permitted_attributes
    unless @user.can?(Simulator, :create) || @user.can?(Simulator, :update)
      return
    end

    %i[short_name name]
  end
end
