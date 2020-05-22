# frozen_string_literal: true

class PirepBroadcastJob < ApplicationJob
  include ActionView::Helpers::NumberHelper
  queue_as :default

  def perform(*_args)
    # Inform the client about the current pending count
    ActionCable.server.broadcast(
      'pireps',
      { pending: number_with_delimiter(Pirep.pending.count) }
    )
  end
end
