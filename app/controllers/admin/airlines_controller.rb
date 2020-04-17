# frozen_string_literal: true

module Admin
  class AirlinesController < ApplicationController
    require 'mini_magick'

    def index
      authorize Airline, :index?
      @q = policy_scope(Airline).ransack(params[:q])
      @q.sorts = 'icao asc' if @q.sorts.empty?
      @airlines = @q.result.page(params[:page])
    end

    def create
      @airline = Airline.new(permitted_attributes(Airline))
      authorize @airline, :create?

      resize_logo

      if @airline.save
        flash[:success] = 'Airline created'
        redirect_to admin_airlines_path
      else
        render :new
      end
    end

    def destroy
      @airline = Airline.friendly.find(params[:id])
      authorize @airline, :destroy?

      if @airline.destroy
        flash[:success] = "#{@airline.name} deleted"
        redirect_to admin_airlines_path
      else
        flash[:danger] = 'Unable to delete airline'
        render :edit
      end
    end

    def edit
      @airline = Airline.friendly.find(params[:id])
      authorize @airline, :edit?
    end

    def new
      @airline = Airline.new
      authorize @airline, :new?
    end

    def update
      @airline = Airline.friendly.find(params[:id])
      authorize @airline, :update?

      resize_logo

      if @airline.update(permitted_attributes(@airline))
        flash[:success] = 'Airline updated'
        redirect_to admin_airlines_path
      else
        render :edit
      end
    end

    private

    # Re-sizes/reformat the icon on upload
    #
    def resize_logo
      logo = params[:airline][:logo]
      return if logo.nil?

      begin
        logo = MiniMagick::Image.new(logo.tempfile.path)
        logo.resize '150x25'
      rescue MiniMagick::Error
        # errors here will be caught in model validation
      end
    end
  end
end
