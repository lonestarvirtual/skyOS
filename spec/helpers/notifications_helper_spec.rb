# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationsHelper, type: :helper do
  describe '#notifications_unread' do
    before :each do
      @user = create(:pilot, :admin)
      @note = create(:notification, pilot: @user, title: 'test', body: 'msg')
    end

    it 'returns unread notifications for the current user' do
      expect(helper).to receive(:current_pilot).and_return(@user)
      expect(helper.notifications_unread).to eq [@note]
    end
  end
end
