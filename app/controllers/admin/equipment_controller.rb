# frozen_string_literal: true

module Admin
  class EquipmentController < ApplicationController
    def index
      authorize Equipment, :index?
      @q = policy_scope(Equipment).ransack(params[:q])
      @q.sorts = 'short_name asc' if @q.sorts.empty?
      @equipment = @q.result.page(params[:page])
    end

    def create
      @equipment = Equipment.new(permitted_attributes(Equipment))
      authorize @equipment, :create?

      if @equipment.save
        flash[:success] = 'Equipment type created'
        redirect_to admin_equipment_index_path
      else
        render :new
      end
    end

    def destroy
      @equipment = Equipment.friendly.find(params[:id])
      authorize @equipment, :destroy?

      if @equipment.destroy
        flash[:success] = "#{@equipment.name} deleted"
        redirect_to admin_equipment_index_path
      else
        flash[:danger] = 'Unable to delete equipment type'
        render :edit
      end
    end

    def edit
      @equipment = Equipment.friendly.find(params[:id])
      authorize @equipment, :edit?
    end

    def new
      @equipment = Equipment.new
      authorize @equipment, :new?
    end

    def update
      @equipment = Equipment.friendly.find(params[:id])
      authorize @equipment, :update?

      if @equipment.update(permitted_attributes(@equipment))
        flash[:success] = 'Equipment type updated'
        redirect_to admin_equipment_index_path
      else
        render :edit
      end
    end
  end
end
