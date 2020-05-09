# frozen_string_literal: true

module Admin
  class SimulatorsController < ApplicationController
    def index
      authorize Simulator, :index?
      @q = policy_scope(Simulator).ransack(params[:q])
      default_sort = 'short_name asc'
      @q.sorts = default_sort if @q.sorts.empty?
      @simulators = @q.result.page(params[:page])
    end

    def create
      @simulator = Simulator.new(permitted_attributes(Simulator))
      authorize @simulator, :create?

      if @simulator.save
        flash[:success] = 'Simulator created'
        redirect_to admin_simulators_path
      else
        render :new
      end
    end

    def destroy
      @simulator = Simulator.find(params[:id])
      authorize @simulator, :destroy?

      if @simulator.destroy
        flash[:success] = 'Simulator deleted'
        redirect_to admin_simulators_path
      else
        flash[:danger] = 'Unable to delete simulator'
        render :edit
      end
    end

    def edit
      @simulator = Simulator.find(params[:id])
      authorize @simulator, :edit?
    end

    def new
      @simulator = Simulator.new
      authorize @simulator, :new?
    end

    def update
      @simulator = Simulator.find(params[:id])
      authorize @simulator, :update?

      if @simulator.update(permitted_attributes(@simulator))
        flash[:success] = 'Simulator updated'
        redirect_to admin_simulators_path
      else
        render :edit
      end
    end
  end
end
