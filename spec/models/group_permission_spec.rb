# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupPermission, type: :model do
  it 'has a valid factory' do
    expect(build(:group_permission)).to be_valid
  end

  let(:group_permission) { build(:group_permission) }

  describe 'ActiveRecord associations' do
    it { expect(group_permission).to belong_to(:group) }
    it { expect(group_permission).to belong_to(:permission) }
  end

  # describe 'ActiveRecord validations' do; end
end
