# frozen_string_literal: true

class Notification < ApplicationRecord
  after_commit :notify_pilot, on: :create

  belongs_to :pilot, optional: false

  validates :title, :body, presence: true

  scope :unread, -> { where(read: false) }
  default_scope { order(created_at: :desc) }

  def self.unread?
    unread.any?
  end

  private

  # Broadcasts new notification via ActionCable to user
  #
  def notify_pilot
    NotificationBroadcastJob.perform_later(self)
  end
end
