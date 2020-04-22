# frozen_string_literal: true

module Admin
  class FlightsController < ApplicationController
    def index
      authorize Flight, :index?
      @q = policy_scope(Flight).ransack(params[:q])
      default_sort = ['airline_name asc', 'number asc', 'leg asc']
      @q.sorts = default_sort if @q.sorts.empty?
      @flights = @q.result.page(params[:page])
    end

    def create
      @flight = Flight.new(permitted_attributes(Flight))
      authorize @flight, :create?

      if @flight.save
        flash[:success] = 'Flight created'
        redirect_to admin_flights_path
      else
        render :new
      end
    end

    def destroy
      @flight = Flight.friendly.find(params[:id])
      authorize @flight, :destroy?

      if @flight.destroy
        flash[:success] = 'Flight deleted'
        redirect_to admin_flights_path
      else
        flash[:danger] = 'Unable to delete flight'
        render :edit
      end
    end

    def edit
      @flight = Flight.friendly.find(params[:id])
      authorize @flight, :edit?
    end

    def new
      @flight = Flight.new
      authorize @flight, :new?
    end

    def update
      @flight = Flight.friendly.find(params[:id])
      authorize @flight, :update?

      if @flight.update(permitted_attributes(@flight))
        flash[:success] = 'Flight updated'
        redirect_to admin_flights_path
      else
        render :edit
      end
    end
  end
end
