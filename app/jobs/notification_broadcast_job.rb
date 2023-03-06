# frozen_string_literal: true

class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    channel_id = notification.pilot.id
    ActionCable.server.broadcast(
      "notifications_#{channel_id}",
      { notification: render_notification(notification) }
    )
  end

  private

  def render_notification(notification)
    # render the notification in the Pilot's timezone
    Time.use_zone notification.pilot.time_zone do
      NotificationsController.render(
        partial: 'notification',
        locals: { notification: }
      ).squish
    end
  end
end
