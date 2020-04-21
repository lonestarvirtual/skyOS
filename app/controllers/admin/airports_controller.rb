# frozen_string_literal: true

module Admin
  class AirportsController < ApplicationController
    def index
      authorize Airport, :index?
      @q = policy_scope(Airport).ransack(params[:q])
      @q.sorts = 'icao asc' if @q.sorts.empty?
      @airports = @q.result.page(params[:page])
    end

    def create
      @airport = Airport.new(permitted_attributes(Airport))
      authorize @airport, :create?

      if @airport.save
        flash[:success] = 'Airport created'
        redirect_to admin_airports_path
      else
        render :new
      end
    end

    def destroy
      @airport = Airport.friendly.find(params[:id])
      authorize @airport, :destroy?

      if @airport.destroy
        flash[:success] = "#{@airport.name} deleted"
        redirect_to admin_airports_path
      else
        flash[:danger] = 'Unable to delete airport'
        render :edit
      end
    end

    def edit
      @airport = Airport.friendly.find(params[:id])
      authorize @airport, :edit?
    end

    def new
      @airport = Airport.new
      authorize @airport, :new?
    end

    def update
      @airport = Airport.friendly.find(params[:id])
      authorize @airport, :update?

      if @airport.update(permitted_attributes(@airport))
        flash[:success] = 'Airport updated'
        redirect_to admin_airports_path
      else
        render :edit
      end
    end
  end
end
