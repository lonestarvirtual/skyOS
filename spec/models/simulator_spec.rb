# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Simulator, type: :model do
  it 'has a valid factory' do
    expect(build(:simulator)).to be_valid
  end

  let(:simulator) { build(:simulator) }

  # describe 'ActiveRecord associations' do
  # end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(simulator).to validate_presence_of(:short_name) }
    it { expect(simulator).to validate_presence_of(:name) }

    # Format validations

    # Inclusion/acceptance of values
    it { expect(simulator).to validate_length_of(:short_name).is_at_most(15) }
    it { expect(simulator).to validate_uniqueness_of(:short_name).case_insensitive }
    it { expect(simulator).to validate_uniqueness_of(:name).case_insensitive }
  end
end
