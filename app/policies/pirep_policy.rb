# frozen_string_literal: true

class PirepPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(pilot: @user)
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def destroy?
    @user.can?(Pirep, :destroy)
  end

  def show?
    true
  end

  # TODO: this permission check is also used on the PirepsChannel
  # we will need to update that administrative check if this is changed
  #
  def update?
    if @user.can?(Pirep, :update)
      true
    elsif (@record.pilot == @user) && @record.status.editable?
      true
    end
  end

  # rubocop:disable Metrics/MethodLength
  # TODO Rubcop doesn't like this (rightfully so). There are lot of parameters
  #      we need to submit on PIREP forms depending on the user. Clean ths up.
  #
  def permitted_attributes
    if @user.can?(Pirep, :update)
      [
        :date, :airline_id, :flight, :leg, :orig_icao, :dest_icao,
        :route, :equipment_id, :simulator_id, :duration, :network_id,
        :status_id, :draft, comments_attributes: %i[_destroy id body]
      ]
    else
      [
        :date, :airline_id, :flight, :leg, :orig_icao, :dest_icao,
        :route, :equipment_id, :simulator_id, :duration, :network_id, :draft,
        comments_attributes: %i[id body]
      ]
    end
  end
  # rubocop:enable Metrics/MethodLength
end
