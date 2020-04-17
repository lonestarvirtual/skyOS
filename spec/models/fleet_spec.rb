# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fleet, type: :model do
  it 'has a valid factory' do
    expect(build(:fleet)).to be_valid
  end

  let(:fleet) { build(:fleet) }

  describe 'ActiveRecord associations' do
    it { expect(fleet).to belong_to(:airline).required }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(fleet).to validate_presence_of(:icao) }
    it { expect(fleet).to validate_presence_of(:short_name) }
    it { expect(fleet).to validate_presence_of(:name) }

    it { expect(fleet).to validate_uniqueness_of(:short_name).scoped_to(:airline_id) }

    # Format validations

    # Inclusion/acceptance of values
    it { expect(fleet).to validate_length_of(:icao).is_at_most(4) }
  end

  describe 'after_validation' do
    it 'upcases the ICAO' do
      fleet.icao = 'icao'
      fleet.valid?
      expect(fleet.icao).to eq 'ICAO'
    end

    it 'upcases the short name' do
      fleet.short_name = 'icao'
      fleet.valid?
      expect(fleet.short_name).to eq 'ICAO'
    end
  end
end
