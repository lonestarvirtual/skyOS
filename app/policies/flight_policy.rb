# frozen_string_literal: true

class FlightPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    # @user.can?(Flight, :read)
    true
  end

  def create?
    @user.can?(Flight, :create)
  end

  def destroy?
    @user.can?(Flight, :destroy)
  end

  def update?
    @user.can?(Flight, :update)
  end

  def permitted_attributes
    if @user.can?(Flight, :create) || @user.can?(Flight, :update)
      %i[
        airline_id equipment_id orig_icao dest_icao number
        leg out_time in_time duration distance
      ]
    else
      []
    end
  end
end
