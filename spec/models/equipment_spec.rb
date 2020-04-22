# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Equipment, type: :model do
  it 'has a valid factory' do
    expect(build(:equipment)).to be_valid
  end

  let(:equipment) { build(:equipment) }

  describe 'ActiveRecord associations' do
    it { expect(equipment).to have_many(:fleets) }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(equipment).to validate_presence_of(:short_name) }
    it { expect(equipment).to validate_presence_of(:icao) }
    it { expect(equipment).to validate_presence_of(:name) }

    it { expect(equipment).to validate_uniqueness_of(:short_name).case_insensitive }

    # Format validations

    # Inclusion/acceptance of values
    it { expect(equipment).to validate_length_of(:icao).is_at_most(4) }
    it { expect(equipment).to validate_length_of(:iata).is_at_most(3) }
  end

  describe 'before_validation' do
    it 'upcases the IATA' do
      equipment.iata = 'ica'
      equipment.valid?
      expect(equipment.iata).to eq 'ICA'
    end

    it 'upcases the ICAO' do
      equipment.icao = 'icao'
      equipment.valid?
      expect(equipment.icao).to eq 'ICAO'
    end

    it 'upcases the short name' do
      equipment.short_name = 'icao'
      equipment.valid?
      expect(equipment.short_name).to eq 'ICAO'
    end
  end
end
