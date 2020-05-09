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

  describe '#after_confirmation' do
    it 'should set the user active after confirming their email' do
      pilot = create(:pilot, :confirmed)

      # after_confirmation is a Devise hook, we just need to
      # validate it updates our 'active' attribute when called
      pilot.send(:after_confirmation)
      expect(pilot.active?).to be_truthy
    end
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

  describe '#full_name' do
    it 'should return the users full name' do
      expect(pilot.full_name).to eq "#{pilot.first_name} #{pilot.last_name}"
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

  describe '#last_flight' do
    it 'should return the last approved Pirep by flight date' do
      pirep = create(:pirep, :approved)
      pilot = pirep.pilot
      expect(pilot.last_flight).to eq pirep
    end
  end

  describe '#pid_to_s' do
    it 'should return the display string for the pilot ID' do
      expect(pilot.pid_to_s).to eq "#{Setting.organization_icao}#{pilot.pid}"
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

  describe '#to_s' do
    it 'should return the display string for the user' do
      expect(pilot.to_s).to eq "#{pilot.full_name} (#{pilot.pid_to_s})"
    end
  end

  describe '#total_distance' do
    it 'should return the total distance of approved flights' do
      sum    = 0
      pilot  = create(:pilot)
      pireps = create_list(:pirep, 4, :approved, pilot: pilot)
      pireps.each { |p| sum += p.distance }

      expect(pilot.total_distance).to eq sum
    end
  end

  describe '#total_flights' do
    it 'should return the total number of approved flights' do
      pilot = create(:pilot)
      create_list(:pirep, 4, :approved, pilot: pilot)
      expect(pilot.total_flights).to eq 4
    end
  end

  describe '#total_hours' do
    it 'should return the total hours of approved flights' do
      sum    = 0
      pilot  = create(:pilot)
      pireps = create_list(:pirep, 4, :approved, pilot: pilot)
      pireps.each { |p| sum += p.duration }

      expect(pilot.total_hours).to eq sum
    end
  end

  describe '#valid_time_zone' do
    it 'is valid with a real time zone' do
      pilot.time_zone = 'America/New_York'
      expect(pilot).to be_valid
    end

    it 'is not valid if the time zone does not exist' do
      pilot.time_zone = 'Fake/Timezone'
      expect(pilot).to_not be_valid
    end

    it 'is not valid if time zone is not present' do
      pilot.time_zone = nil
      pilot.send(:valid_time_zone)

      # use send to test private method as validation will set
      # time zone to UTC if normally left blank
      expect(pilot.errors).to have_key :time_zone
    end
  end
end
