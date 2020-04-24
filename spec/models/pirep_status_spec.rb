# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PirepStatus, type: :model do
  it 'has a valid factory' do
    expect(build(:pirep_status)).to be_valid
  end

  let(:pirep_status) { build(:pirep_status) }

  describe 'ActiveRecord associations' do
    it { expect(pirep_status).to have_many(:pireps) }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(pirep_status).to validate_presence_of(:name) }

    # Format validations

    # Inclusion/acceptance of values
    it { expect(pirep_status).to validate_uniqueness_of(:name).case_insensitive }
  end
end
