# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fleet, type: :model do
  it 'has a valid factory' do
    expect(build(:fleet)).to be_valid
  end

  let(:fleet) { build(:fleet) }

  describe 'ActiveRecord associations' do
    it { expect(fleet).to belong_to(:airline).required }
    it { expect(fleet).to belong_to(:equipment).required }
  end

  describe 'ActiveRecord validations' do
    # Basic validations

    # Format validations

    # Inclusion/acceptance of values
    it {
      expect(fleet).to validate_uniqueness_of(:equipment_id) \
        .scoped_to(:airline_id) \
        .case_insensitive \
        .with_message('already in use with this airline')
    }
  end
end
