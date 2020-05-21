# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  it 'has a valid factory' do
    expect(build(:notification)).to be_valid
  end

  let(:notification) { build(:notification) }

  describe 'ActiveRecord associations' do
    it { expect(notification).to belong_to(:pilot).optional(false) }
  end

  describe 'ActiveRecord callbacks' do
    it { is_expected.to callback(:notify_pilot).after(:commit) }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(notification).to validate_presence_of(:title) }
    it { expect(notification).to validate_presence_of(:body) }

    # Format validations

    # Inclusion/acceptance of values
  end

  describe '#self.unread?' do
    it 'is true if there are unread notifications' do
      create(:notification, read: false)
      expect(Notification.unread?).to be_truthy
    end

    it 'is false if there are no unread notifications' do
      create(:notification, read: true)
      expect(Notification.unread?).to be_falsey
    end
  end
end
