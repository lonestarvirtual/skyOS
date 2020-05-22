# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PirepsChannel, type: :channel do
  before :each do
    stub_connection(current_user: user)
  end

  context 'PIREP administrators ' do
    let(:user) { create(:pilot, :admin) }

    it 'successfully subscribes' do
      subscribe
      expect(subscription).to be_confirmed
    end
  end

  context 'non-administrative users' do
    let(:user) { create(:pilot) }

    it 'do not subscribe' do
      subscribe
      expect(subscription).to_not be_confirmed
    end
  end
end
