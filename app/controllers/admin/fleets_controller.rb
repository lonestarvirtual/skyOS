# frozen_string_literal: true

module Admin
  class FleetsController < ApplicationController
    require 'mini_magick'

    def index
      authorize Fleet, :index?
      @q = policy_scope(Fleet).ransack(params[:q])
      @q.sorts = 'airline,icao asc' if @q.sorts.empty?
      @fleets = @q.result.page(params[:page])
    end

    def create
      @fleet = Fleet.new(permitted_attributes(Fleet))
      authorize @fleet, :create?

      resize_image

      if @fleet.save
        flash[:success] = 'Fleet created'
        redirect_to admin_fleets_path
      else
        render :new
      end
    end

    def destroy
      @fleet = Fleet.find(params[:id])
      authorize @fleet, :destroy?

      if @fleet.destroy
        flash[:success] = "#{@fleet.name} deleted"
        redirect_to admin_fleets_path
      else
        flash[:danger] = 'Unable to delete fleet'
        render :edit
      end
    end

    def edit
      @fleet = Fleet.find(params[:id])
      authorize @fleet, :edit?

      @fleet.repaints.build
    end

    def new
      @fleet = Fleet.new
      authorize @fleet, :new?

      @fleet.repaints.build
    end

    def update
      @fleet = Fleet.find(params[:id])
      authorize @fleet, :update?

      resize_image

      if @fleet.update(permitted_attributes(@fleet))
        flash[:success] = 'Fleet updated'
        redirect_to admin_fleets_path
      else
        render :edit
      end
    end

    private

    # Re-sizes/reformat the image on upload
    #
    def resize_image
      image = params[:fleet][:image]
      return if image.nil?

      begin
        image = MiniMagick::Image.new(image.tempfile.path)
        image.resize '175x260>'
      rescue MiniMagick::Error
        # errors here will be caught in model validation
      end
    end
  end
end
