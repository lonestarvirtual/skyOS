# frozen_string_literal: true

class NotificationBroadcastJob < ApplicationJob
  queue_as :high_priority

  def perform(notification)
    channel_id = notification.pilot.id
    ActionCable.server.broadcast(
      "notifications_#{channel_id}",
      { notification: render_notification(notification) }
    )
  end

  private

  def render_notification(notification)
    NotificationsController.render(
      partial: 'notification',
      locals: { notification: notification }
    ).squish
  end
end
