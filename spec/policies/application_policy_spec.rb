# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationPolicy, type: :policy do
  subject { described_class.new(user, nil) }

  context 'by default' do
    let(:user) { create(:pilot) }

    it { is_expected.to forbid_actions(%i[index show destroy]) }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
  end
end
