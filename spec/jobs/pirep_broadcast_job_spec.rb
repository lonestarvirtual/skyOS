# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PirepBroadcastJob, type: :job do
  describe '#perform' do
    it 'enqueues the job for later' do
      expect do
        PirepBroadcastJob.perform_later
      end.to have_enqueued_job.on_queue('default').at(:no_wait)
    end

    it 'sends an ActionCable broadcast' do
      expect do
        PirepBroadcastJob.perform_now
      end.to have_broadcasted_to('pireps')
    end

    it 'transmits the current pending count' do
      expect do
        PirepBroadcastJob.perform_now
      end.to have_broadcasted_to('pireps').with(a_hash_including(:pending))
    end
  end
end
