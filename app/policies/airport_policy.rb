# frozen_string_literal: true

class AirportPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.can?(Airport, :read)
  end

  def create?
    @user.can?(Airport, :create)
  end

  def destroy?
    @user.can?(Airport, :destroy)
  end

  def update?
    @user.can?(Airport, :update)
  end

  def permitted_attributes
    return unless @user.can?(Airport, :create) || @user.can?(Airport, :update)

    %i[icao iata name city latitude longitude time_zone]
  end
end
