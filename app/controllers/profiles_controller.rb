# frozen_string_literal: true

class ProfilesController < ApplicationController
  def edit
    @pilot = current_pilot
    authorize @pilot, :profile_show?
  end

  def update
    @pilot = current_pilot
    authorize @pilot, :profile_update?

    if @pilot.update(profile_params)
      flash[:success] = 'Profile updated'
      redirect_to edit_profile_path
    else
      render :edit
    end
  end

  private

  def profile_params
    # remove password/confirmation if blank
    prune_password_fields

    params.require(:pilot).permit(
      :email, :password, :password_confirmation, :time_zone
    )
  end

  def prune_password_fields
    return if params[:pilot][:password].present? \
              || params[:pilot][:password_confirmation].present?

    params[:pilot].delete :password
    params[:pilot].delete :password_confirmation
  end
end
