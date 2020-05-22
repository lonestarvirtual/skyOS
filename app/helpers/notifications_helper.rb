# frozen_string_literal: true

module NotificationsHelper
  def notifications_unread
    current_pilot.notifications.unread
  end

  def show_pirep_notification?
    admin_link_to('PIREPs', Pirep).present?
  end
end
