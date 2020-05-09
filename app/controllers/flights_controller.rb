# frozen_string_literal: true

class FlightsController < ApplicationController
  def index
    authorize Flight, :index?
    @q = policy_scope(Flight).ransack(params[:q])
    default_sort = ['airline_name asc', 'number asc', 'leg asc']
    @q.sorts = default_sort if @q.sorts.empty?
    @flights = @q.result.page(params[:page])
  end
end
