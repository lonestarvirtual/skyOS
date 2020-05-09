# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'has a valid factory' do
    expect(build(:group)).to be_valid
  end

  let(:group) { build(:group) }

  describe 'ActiveRecord associations' do
    it { expect(group).to have_many(:group_permissions) }
    it { expect(group).to have_many(:permissions).through(:group_permissions) }
    it { expect(group).to have_many(:pilots) }
  end

  describe 'ActiveRecord validations' do
    # Basic validations
    it { expect(group).to validate_presence_of(:name) }
    it { expect(group).to validate_presence_of(:description) }

    # Format validations

    # Inclusion/acceptance of values
  end

  describe 'capitalize name' do
    it 'should capitalize the name' do
      group.name = 'test'
      group.valid?
      expect(group.name).to eq 'Test'
    end
  end
end
