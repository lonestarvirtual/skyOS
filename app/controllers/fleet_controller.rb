# frozen_string_literal: true

class FleetController < ApplicationController
  skip_before_action :authenticate_pilot!, only: %i[index]
  skip_after_action  :verify_authorized, only: %i[index download]

  def index
    fleet = Fleet.joins(:airline, :equipment)
    fleet = fleet.order('airlines.name').order('equipment.name')
    @fleet = fleet.page(params[:page]).per(10)
  end

  def download
    repaint = Repaint.find_by(id: params[:repaint_id])
    redirect_to rails_blob_path(repaint.file, disposition: 'attachment')
  end
end
