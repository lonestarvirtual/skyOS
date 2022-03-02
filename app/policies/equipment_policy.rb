# frozen_string_literal: true

class EquipmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.can?(Equipment, :read)
  end

  def create?
    @user.can?(Equipment, :create)
  end

  def destroy?
    @user.can?(Equipment, :destroy)
  end

  def update?
    @user.can?(Equipment, :update)
  end

  def permitted_attributes
    return unless @user.can?(Equipment, :create) || @user.can?(Equipment, :update)

    %i[icao iata name short_name description]
  end
end
