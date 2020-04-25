# frozen_string_literal: true

class PilotsController < ApplicationController
  skip_before_action :authenticate_pilot!, only: %i[index]
  skip_after_action  :verify_authorized, only: %i[index]

  def index
    @q = policy_scope(Pilot).ransack(params[:q])
    @q.sorts = ['pid asc'] if @q.sorts.empty?
    @pilots = @q.result.page(params[:page])
  end
end
