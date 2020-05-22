# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationPolicy, type: :policy do
  subject { described_class.new(user, notification) }

  let(:notification) { create(:notification) }

  context 'as a pilot' do
    let(:user) { create(:pilot) }

    it { is_expected.to permit_actions(%i[update destroy]) }

    it { is_expected.to forbid_actions(%i[index]) }
    it { is_expected.to forbid_new_and_create_actions }
  end
end
