# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repaint, type: :model do
  it 'has a valid factory' do
    expect(build(:repaint)).to be_valid
  end

  let(:repaint) { build(:repaint) }

  describe 'ActiveRecord associations' do
    it { expect(repaint).to belong_to(:fleet).required }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(repaint).to validate_presence_of(:name) }
    it { expect(repaint).to validate_presence_of(:file) }

    # Format validations

    # Inclusion/acceptance of values
  end

  describe '#file' do
    subject { create(:repaint).file }

    it { is_expected.to be_an_instance_of(ActiveStorage::Attached::One) }
  end
end
