# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Announcement, type: :model do
  it 'has a valid factory' do
    expect(build(:announcement)).to be_valid
  end

  let(:announcement) { build(:announcement) }

  describe 'ActiveModel callbacks' do
    it { expect(announcement).to callback(:set_initial_times).after(:initialize) }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(announcement).to validate_presence_of(:title) }
    it { expect(announcement).to validate_presence_of(:body) }

    # Format validations

    # Inclusion/acceptance of values
  end

  describe 'custom validations' do
    it 'is invalid if the start time is after the end time' do
      announcement.start_at = announcement.end_at + 1.second
      expect(announcement).to_not be_valid
    end

    it 'is invalid if the end time is before now' do
      announcement.end_at = Time.current - 1.second
      expect(announcement).to_not be_valid
    end
  end

  describe '#now' do
    before :all do
      create(:announcement)
    end

    it 'only returns 1 announcement' do
      expect(Announcement.now).to be_a_kind_of Announcement
    end

    it 'should return an announcement with a start time before present time' do
      expect(Announcement.now.start_at).to be <= Time.current
    end

    it 'should return an announcement that has not ended yet' do
      expect(Announcement.now.end_at).to be >= Time.current
    end
  end

  describe '#purge' do
    before :each do
      end_time = Time.current - 1.day
      create_list(:announcement, 4, :skip_validation, end_at: end_time)
    end

    it 'purges announcements that have already expired' do
      expect do
        Announcement.purge
      end.to change(Announcement, :count).by(-4)
    end
  end

  describe '#set_initial_times' do
    it 'should set the time to the current time' do
      expect(announcement.start_at.class).to eq ActiveSupport::TimeWithZone
      expect(announcement.end_at.class).to eq ActiveSupport::TimeWithZone
    end
  end
end
