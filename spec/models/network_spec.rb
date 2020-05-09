# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Network, type: :model do
  it 'has a valid factory' do
    expect(build(:network)).to be_valid
  end

  let(:network) { build(:network) }

  describe 'ActiveRecord associations' do
    it { expect(network).to have_many(:pireps) }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(network).to validate_presence_of(:name) }

    # Format validations

    # Inclusion/acceptance of values
    it { expect(network).to validate_uniqueness_of(:name).case_insensitive }
  end
end
