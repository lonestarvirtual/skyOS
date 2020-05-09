# frozen_string_literal: true

class AirlinePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.can?(Airline, :read)
  end

  def create?
    @user.can?(Airline, :create)
  end

  def destroy?
    @user.can?(Airline, :destroy)
  end

  def update?
    @user.can?(Airline, :update)
  end

  def permitted_attributes
    if @user.can?(Airline, :create) || @user.can?(Airline, :update)
      %i[logo icao iata name remove_logo]
    else
      []
    end
  end
end
