# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe '#membership_statistics' do
    it 'returns a hash of membership statistics' do
      expected_stats = {}
      expected_stats[:routes]        = Flight.all.count
      expected_stats[:pilots]        = Pilot.where(active: true).count
      expected_stats[:total_flights] = Pirep.approved.count
      expected_stats[:total_hours]   = Pirep.approved.sum(:duration)

      expect(helper.membership_statistics).to eq expected_stats
    end
  end
end
