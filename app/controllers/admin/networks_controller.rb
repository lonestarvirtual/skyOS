# frozen_string_literal: true

module Admin
  class NetworksController < ApplicationController
    def index
      authorize Network, :index?
      @q = policy_scope(Network).ransack(params[:q])
      @q.sorts = ['name asc'] if @q.sorts.empty?
      @networks = @q.result.page(params[:page])
    end

    def create
      @network = Network.new(permitted_attributes(Network))
      authorize @network, :create?

      if @network.save
        flash[:success] = 'Network created'
        redirect_to admin_networks_path
      else
        render :new
      end
    end

    def destroy
      @network = Network.find(params[:id])
      authorize @network, :destroy?

      if @network.destroy
        flash[:success] = 'Network deleted'
        redirect_to admin_networks_path
      else
        flash[:danger] = 'Unable to delete fleet'
        render :edit
      end
    end

    def edit
      @network = Network.find(params[:id])
      authorize @network, :edit?
    end

    def new
      @network = Network.new
      authorize @network, :new?
    end

    def update
      @network = Network.find(params[:id])
      authorize @network, :update?

      if @network.update(permitted_attributes(@network))
        flash[:success] = 'Network updated'
        redirect_to admin_networks_path
      else
        render :edit
      end
    end
  end
end
