# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlePolicy, type: :policy do
  subject { described_class.new(user, article) }

  let!(:article) { create(:article) }
  let!(:article_public) { create(:article, private: false) }
  let(:scope) { Pundit.policy_scope!(user, Article) }

  context 'being a pilot' do
    let(:user) { create(:pilot) }

    it { is_expected.to permit_actions(%i[index]) }
    it { is_expected.to forbid_new_and_create_actions }
    it { expect(scope.to_a).to match_array([article, article_public]) }
  end

  context 'being an administrator' do
    let(:user) { create(:pilot, :admin) }

    it { is_expected.to permit_actions(%i[index]) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { expect(scope.to_a).to match_array([article, article_public]) }
  end

  context 'being an unauthenticated actor' do
    let(:user) { nil }

    it { is_expected.to permit_actions(%i[index]) }
    it { is_expected.to forbid_new_and_create_actions }
    it { expect(scope.to_a).to match_array([article_public]) }
  end
end
