# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FleetPolicy, type: :policy do
  subject { described_class.new(user, fleet) }

  let(:fleet) { create(:fleet) }

  context 'being a pilot' do
    let(:user) { create(:pilot) }

    it { is_expected.to forbid_new_and_create_actions }
  end

  context 'being an administrator' do
    let(:user) { create(:pilot, :admin) }

    it { is_expected.to permit_actions(%i[index]) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
  end
end
