# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pirep, type: :model do
  it 'has a valid factory' do
    expect(build(:pirep)).to be_valid
  end

  let(:pirep) { build(:pirep) }

  describe 'ActiveRecord associations' do
    it { expect(pirep).to belong_to(:pilot).required }
    it { expect(pirep).to belong_to(:airline).required }
    it { expect(pirep).to belong_to(:orig).required }
    it { expect(pirep).to belong_to(:dest).required }
    it { expect(pirep).to belong_to(:equipment).required }
    it { expect(pirep).to belong_to(:simulator).required }
    it { expect(pirep).to belong_to(:network).optional }
    # it { expect(pirep).to belong_to(:status).required }
    it { expect(pirep).to have_many(:comments) }
  end

  describe 'ActiveRecord callbacks' do
    it { is_expected.to callback(:calculate_distance).before(:validation) }
    it { is_expected.to callback(:notify_admin).after(:commit) }
    it { is_expected.to callback(:notify_pilot).after(:commit) }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(pirep).to validate_presence_of(:date) }
    it { expect(pirep).to validate_presence_of(:flight) }
    it { expect(pirep).to validate_presence_of(:leg) }
    it { expect(pirep).to validate_presence_of(:route) }
    it { expect(pirep).to validate_presence_of(:duration) }
    # it { expect(pirep).to validate_presence_of(:distance) }
    # it { expect(pirep).to validate_presence_of(:status_id) }

    # Format validations

    # Inclusion/acceptance of values
    it { expect(pirep).to validate_numericality_of(:flight).is_greater_than_or_equal_to(1) }
    it { expect(pirep).to validate_numericality_of(:flight).is_less_than_or_equal_to(32_767) }
    it { expect(pirep).to validate_numericality_of(:leg).is_greater_than_or_equal_to(1) }
    it { expect(pirep).to validate_numericality_of(:leg).is_less_than_or_equal_to(127) }
    it { expect(pirep).to validate_numericality_of(:distance).is_greater_than_or_equal_to(0) }
    it { expect(pirep).to validate_numericality_of(:distance).is_less_than_or_equal_to(32_767) }
    it { expect(pirep).to validate_numericality_of(:duration).is_greater_than_or_equal_to(0) }
    it { expect(pirep).to validate_numericality_of(:duration).is_less_than_or_equal_to(99.9) }
  end

  describe '#draft=' do
    it 'sets the status of the Pirep to draft when set to 1' do
      pirep.draft = 1
      expect(pirep.status).to eq PirepStatus.find_by(name: 'Draft')
    end

    it 'sets the status of the Pirep to Submitted set to 0' do
      pirep.draft = 0
      expect(pirep.status).to eq PirepStatus.find_by(name: 'Submitted')
    end
  end

  describe '#notify_pilot' do
    it 'creates a notification when the PIREP has been approved' do
      pirep = create(:pirep, :approved)
      expect(pirep.pilot.notifications).to_not be_empty
    end

    it 'does not create a notification unless the PIREP has been approved' do
      pirep = create(:pirep, :draft)
      expect(pirep.pilot.notifications).to be_empty
    end
  end
end
