# frozen_string_literal: true

class LogbooksController < ApplicationController
  skip_before_action :authenticate_pilot!, only: :show
  skip_after_action  :verify_authorized, only: :show

  # rubocop:disable Metrics/AbcSize
  def show
    authorize Pirep, :index?
    @pilot = Pilot.friendly.find(params[:pilot_id])

    @q = @pilot.pireps.ransack(params[:q])
    @q.sorts = ['date desc', 'created_at desc'] if @q.sorts.empty?

    @pireps = @q.result.page(params[:page])
  end
  # rubocop:enable Metrics/AbcSize
end
