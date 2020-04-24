# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pilot, type: :model do
  it 'has a valid factory' do
    expect(build(:pilot)).to be_valid
  end

  let(:pilot) { build(:pilot) }

  describe 'ActiveRecord associations' do
    it { expect(pilot).to have_many(:pireps) }

    it do
      # stub the callback so that default group is not assigned (for this test)
      allow_any_instance_of(Pilot).to receive(:assign_group).and_return(nil)
      expect(pilot).to belong_to(:group).required
    end
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(pilot).to validate_presence_of(:first_name) }
    it { expect(pilot).to validate_presence_of(:last_name) }

    # Format validations
    it { expect(pilot).to validate_numericality_of(:pid).only_integer }

    # Inclusion/acceptance of values
  end

  describe 'can?' do
    before :each do
      @pilot = create(:pilot)
    end

    it 'should return true if the pilot has the permission' do
      @pilot.update_attribute(:group, Group.find_by(name: 'Admin'))
      expect(@pilot.can?(Group, :destroy)).to eq true
    end

    it 'should return false if the pilot does not have permission' do
      @pilot.update_attribute(:group, Group.find_by(name: 'Pilot'))
      expect(@pilot.can?(Group, :destroy)).to eq false
    end
  end

  describe 'group' do
    it 'should be assigned the pilot group' do
      group = Group.find_by(name: 'Pilot')
      pilot.valid?
      expect(pilot.group).to eq group
    end
  end

  describe 'ID' do
    it 'should be assigned starting value if no other pilots exist' do
      pilot.valid?
      expect(pilot.pid).to eq 100
    end

    it 'should be assigned starting value if pilots exist below the number' do
      create(:pilot, pid: 1)
      pilot.valid? # build a new pilot and test validity
      expect(pilot.pid).to eq 100
    end

    it 'should be assigned the next available value if pilots exist' do
      create(:pilot)
      pilot.valid?
      expect(pilot.pid).to eq 101
    end
  end

  describe 'titleize_name' do
    it 'should titleize the first name' do
      first_name = pilot.first_name
      pilot.valid?
      expect(pilot.first_name).to eq first_name.titleize
    end

    it 'should titleize the last name' do
      last_name = pilot.last_name
      pilot.valid?
      expect(pilot.last_name).to eq last_name.titleize
    end
  end
end
