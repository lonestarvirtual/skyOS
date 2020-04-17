# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Permission, type: :model do
  it 'has a valid factory' do
    expect(build(:permission)).to be_valid
  end

  let(:permission) { build(:permission) }

  describe 'ActiveRecord associations' do
    it { expect(permission).to have_many(:group_permissions) }
    it { expect(permission).to have_many(:groups).through(:group_permissions) }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(permission).to validate_presence_of(:model) }
    it { expect(permission).to validate_presence_of(:action) }
    it { expect(permission).to validate_presence_of(:description) }

    # Format validations

    # Inclusion/acceptance of values
  end
end
