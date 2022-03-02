# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PirepComment, type: :model do
  it 'has a valid factory' do
    expect(build(:pirep_comment)).to be_valid
  end

  let(:pirep_comment) { build(:pirep_comment) }

  describe 'ActiveRecord associations' do
    it { expect(pirep_comment).to belong_to(:pirep).required }
    it { expect(pirep_comment).to belong_to(:author).required }
  end

  describe 'ActiveRecord validations' do
    # Basic validations

    # Format validations

    # Inclusion/acceptance of values
    it { expect(pirep_comment).to_not allow_value('').for(:body) }
  end
end
