# frozen_string_literal: true

module Admin
  class PilotsController < ApplicationController
    def index
      authorize Pilot, :index?
      @q = Pilot.ransack(params[:q])
      default_sort = ['pid asc']
      @q.sorts = default_sort if @q.sorts.empty?
      @pilots = @q.result.page(params[:page])
    end

    def destroy
      @pilot = Pilot.friendly.find(params[:id])
      authorize @pilot, :destroy?

      if @pilot.destroy
        flash[:success] = "#{@pilot.full_name} deleted"
        redirect_to admin_pilots_path
      else
        flash[:danger] = 'Unable to delete Pilot'
        render :edit
      end
    end

    def edit
      @pilot = Pilot.friendly.find(params[:id])
      authorize @pilot, :edit?
    end

    def update
      @pilot = Pilot.friendly.find(params[:id])
      authorize @pilot, :update?

      if @pilot.update(permitted_attributes(@pilot))
        flash[:success] = 'Pilot updated'
        redirect_to admin_pilots_path
      else
        render :edit
      end
    end
  end
end
