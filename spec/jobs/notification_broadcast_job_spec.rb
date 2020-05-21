# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationBroadcastJob, type: :job do
  describe '#perform' do
    before :each do
      @notification = create(:notification)
    end

    it 'enqueues the job for later' do
      expect do
        NotificationBroadcastJob.perform_later(@notification)
      end.to have_enqueued_job.on_queue('default').at(:no_wait)
    end

    it 'sends an ActionCable broadcast' do
      expect do
        NotificationBroadcastJob.perform_now(@notification)
      end.to have_broadcasted_to("notifications_#{@notification.pilot.id}")
    end

    it 'renders the notification' do
      expect do
        NotificationBroadcastJob.perform_now(@notification)
      end.to have_broadcasted_to("notifications_#{@notification.pilot.id}")
        .with(a_hash_including(:notification))
    end
  end
end
