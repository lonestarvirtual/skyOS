# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Airline, type: :model do
  it 'has a valid factory' do
    expect(build(:airline)).to be_valid
  end

  let(:airline) { build(:airline) }

  describe 'ActiveRecord associations' do
    it { expect(airline).to have_many(:fleets) }
    it { expect(airline).to have_many(:pireps) }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(airline).to validate_presence_of(:icao) }
    it { expect(airline).to validate_presence_of(:name) }

    # Format validations

    # Inclusion/acceptance of values
    it { expect(airline).to validate_length_of(:icao).is_at_most(3) }
    it { expect(airline).to validate_length_of(:iata).is_at_most(2) }
  end

  describe 'after_validation' do
    it 'upcases the ICAO' do
      airline.icao = 'ica'
      airline.valid?
      expect(airline.icao).to eq 'ICA'
    end

    it 'upcases the IATA' do
      airline.iata = 'ia'
      airline.valid?
      expect(airline.iata).to eq 'IA'
    end

    it 'titleizes the name' do
      airline.name = 'one name'
      airline.valid?
      expect(airline.name).to eq 'One Name'
    end
  end
end
