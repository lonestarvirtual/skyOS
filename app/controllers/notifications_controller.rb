# frozen_string_literal: true

class NotificationsController < ApplicationController
  after_action :verify_policy_scoped

  # rubocop:disable Metrics/MethodLength
  def destroy
    @notifications = if params[:id] == 'all'
                       policy_scope(Notification)
                     else
                       policy_scope(Notification).where(id: params[:id])
                     end
    authorize @notifications, :update?

    if @notifications.destroy_all
      head :ok
    else
      # TODO: see associated case in notifications_request_spec.rb
      redirect_to root_path, alert: 'Unable to delete notification'
    end
  end
  # rubocop:enable Metrics/MethodLength
end
