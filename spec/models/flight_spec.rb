# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flight, type: :model do
  it 'has a valid factory' do
    expect(build(:flight)).to be_valid
  end

  let(:flight) { build(:flight) }

  describe 'ActiveRecord associations' do
    it { expect(flight).to belong_to(:airline).required }
    it { expect(flight).to belong_to(:equipment).required }
    it { expect(flight).to belong_to(:orig).required }
    it { expect(flight).to belong_to(:dest).required }
  end

  describe 'ActiveRecord callbacks' do
    it { is_expected.to callback(:calculate_distance).before(:validation) }
    it { is_expected.to callback(:calculate_duration).before(:validation) }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(flight).to validate_presence_of(:number) }
    it { expect(flight).to validate_presence_of(:leg) }
    it { expect(flight).to validate_presence_of(:out_time) }
    it { expect(flight).to validate_presence_of(:in_time) }
    # it { expect(flight).to validate_presence_of(:duration) }
    # it { expect(flight).to validate_presence_of(:distance) }

    # Format validations
    it { expect(flight).to validate_numericality_of(:number).only_integer }
    it { expect(flight).to validate_numericality_of(:leg).only_integer }
    it { expect(flight).to validate_numericality_of(:distance).only_integer }
    it { expect(flight).to validate_numericality_of(:duration) }

    # Inclusion/acceptance of values
    it { expect(flight).to validate_numericality_of(:number).is_greater_than_or_equal_to(1) }
    it { expect(flight).to validate_numericality_of(:number).is_less_than_or_equal_to(32_767) }
    it { expect(flight).to validate_numericality_of(:leg).is_greater_than_or_equal_to(1) }
    it { expect(flight).to validate_numericality_of(:leg).is_less_than_or_equal_to(127) }
    it { expect(flight).to validate_numericality_of(:distance).is_greater_than_or_equal_to(0) }
    it { expect(flight).to validate_numericality_of(:distance).is_less_than_or_equal_to(32_767) }
    it { expect(flight).to validate_numericality_of(:duration).is_greater_than_or_equal_to(0) }
    it { expect(flight).to validate_numericality_of(:duration).is_less_than_or_equal_to(99.9) }
  end

  describe '#airline_operates_equipment' do
    it 'is invalid if the airline does not have a fleet with this equipment' do
      flight.equipment = create(:equipment)
      expect(flight).to_not be_valid
    end
  end

  describe '#dest_icao' do
    it 'returns the ICAO ID of the destination airport' do
      expect(flight.dest_icao).to eq flight.dest.icao
    end

    it 'returns nil if the destination airport is not set' do
      expect(build(:flight, dest: nil).dest_icao).to be_nil
    end
  end

  describe '#dest_icao=' do
    it 'sets the destination airport by ICAO ID' do
      airport = create(:airport, icao: 'TEST')
      flight = build(:flight)
      flight.dest_icao = 'TEST'
      expect(flight.dest).to eq airport
    end

    it 'sets the destination airport to nil if ICAO not found' do
      flight = build(:flight)
      flight.dest_icao = 'NONE'
      expect(flight.dest).to eq nil
    end
  end

  describe '#in_time_local' do
    it "returns the arrival time in the airport's time zone" do
      offset = ActiveSupport::TimeZone.new(flight.dest.time_zone).utc_offset
      expect(flight.in_time_local.time_zone.utc_offset).to eq offset
    end
  end

  describe '#orig_icao' do
    it 'returns the ICAO ID of the origin airport' do
      expect(flight.orig_icao).to eq flight.orig.icao
    end

    it 'returns nil if the origin airport is not set' do
      expect(build(:flight, orig: nil).orig_icao).to be_nil
    end
  end

  describe '#orig_icao=' do
    it 'sets the origin airport by ICAO ID' do
      airport = create(:airport, icao: 'TEST')
      flight = build(:flight)
      flight.orig_icao = 'TEST'
      expect(flight.orig).to eq airport
    end

    it 'sets the origin airport to nil if ICAO not found' do
      flight = build(:flight)
      flight.orig_icao = 'NONE'
      expect(flight.orig).to eq nil
    end
  end

  describe '#out_time_local' do
    it "returns the departure time in the airport's time zone" do
      offset = ActiveSupport::TimeZone.new(flight.orig.time_zone).utc_offset
      expect(flight.out_time_local.time_zone.utc_offset).to eq offset
    end
  end
end
