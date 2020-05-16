# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationsChannel, type: :channel do
  let(:user) { create(:pilot) }

  before :each do
    stub_connection(current_user: user)
  end

  it 'successfully subscribes' do
    subscribe
    expect(subscription).to be_confirmed
  end
end
