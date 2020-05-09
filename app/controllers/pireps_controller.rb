# frozen_string_literal: true

class PirepsController < ApplicationController
  include PirepCommentable

  skip_before_action :authenticate_pilot!, only: :show
  skip_after_action  :verify_authorized, only: :show

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def create
    @pirep = Pirep.new(permitted_attributes(Pirep))
    @pirep.pilot = current_pilot
    authorize @pirep, :create?

    # set/enforce comment author
    comment_author(@pirep)

    if @pirep.save
      flash[:success] = 'PIREP created'
      redirect_to pilot_logbook_path(current_pilot)
    else
      @pirep.comments.build if @pirep.comments.empty?
      render :new
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def edit
    @pirep = Pirep.find(params[:id])
    authorize @pirep, :edit?

    @pirep.comments.build
  end

  def new
    @pirep = Pirep.new(pilot: current_pilot, date: DateTime.now)
    authorize @pirep, :new?

    @pirep.comments.build
  end

  def show
    @pirep = Pirep.find(params[:id])
  end

  def update
    @pirep = policy_scope(Pirep).find(params[:id])
    authorize @pirep, :update?

    @pirep.assign_attributes(permitted_attributes(@pirep))

    # set/enforce comment author
    comment_author(@pirep)

    if @pirep.save
      flash[:success] = 'PIREP updated'
      redirect_to pilot_logbook_path(current_pilot)
    else
      render :edit
    end
  end
end
