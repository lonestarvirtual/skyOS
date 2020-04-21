# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Airport, type: :model do
  it 'has a valid factory' do
    expect(build(:airport)).to be_valid
  end

  let(:airport) { build(:airport) }

  # describe 'ActiveRecord associations' do
  # end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(airport).to validate_presence_of(:icao) }
    it { expect(airport).to validate_presence_of(:name) }
    it { expect(airport).to validate_presence_of(:city) }

    # Format validations
    it { expect(airport).to validate_length_of(:icao).is_at_most(4) }
    it { expect(airport).to validate_length_of(:iata).is_at_most(3) }

    # Inclusion/acceptance of values
    it { expect(airport).to validate_numericality_of(:latitude).is_greater_than_or_equal_to(-90).is_less_than_or_equal_to(90) }
    it { expect(airport).to validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180).is_less_than_or_equal_to(180) }
  end

  describe '#set_time_zone' do
    it 'sets the timezone from lat/long if blank' do
      airport.time_zone = nil
      airport.latitude  = 39.22320
      airport.longitude = -106.86900
      airport.valid?
      expect(airport.time_zone).to eq 'America/Denver'
    end
  end

  describe '#upcase_iata' do
    it 'upcases the IATA code' do
      airport.iata = 'aaa'
      airport.valid?
      expect(airport.iata).to eq 'AAA'
    end
  end

  describe '#upcase_icao' do
    it 'upcases teh ICAO code' do
      airport.icao = 'aaaa'
      airport.valid?
      expect(airport.icao).to eq 'AAAA'
    end
  end

  describe '#valid_time_zone' do
    it 'is not valid if the time zone does not exist' do
      airport.time_zone = 'Fake/Timezone'
      expect(airport).to_not be_valid
    end

    it 'is valid with a real time zone' do
      airport.time_zone = 'America/New_York'
      expect(airport).to be_valid
    end
  end
end
