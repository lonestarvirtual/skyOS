# frozen_string_literal: true

class PirepsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'pireps'
    reject unless current_user.can? Pirep, %i[update]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
