# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#active_class' do
    it 'returns "active" if the current page is the current path' do
      expect(helper).to receive(:current_page?).and_return(true)
      expect(helper.active_class('pages/some/path')).to eq 'active'
    end

    it 'returns nil if the current page is not the current path' do
      expect(helper).to receive(:current_page?).and_return(false)
      expect(helper.active_class('pages/some/path')).to eq nil
    end
  end

  describe '#admin_link_to' do
    context 'with administrative privileges' do
      before :each do
        @user = create(:pilot, :admin)
      end

      it 'returns a link if the user has permissions' do
        expect(helper).to receive(:current_pilot).and_return(@user)
        expect(
          helper.admin_link_to('Airlines', Airline, admin_airlines_path).class
        ).to eq ActiveSupport::SafeBuffer
      end
    end

    context 'without administrative privileges' do
      before :each do
        @user = create(:pilot)
      end

      it 'does not return a link if the user does not have permissions' do
        expect(helper).to receive(:current_pilot).and_return(@user)
        expect(
          helper.admin_link_to('Airlines', Airline, admin_airlines_path)
        ).to be_nil
      end
    end
  end

  describe '#copyright_years' do
    it 'returns a copyright string for the current year' do
      Setting.copyright_year = Time.current.strftime('%Y')
      expect(helper.copyright_years).to eq Time.current.year
    end

    it 'returns a copyright string for multiple years' do
      Setting.copyright_year = 1.year.ago.year
      start_year = 1.year.ago.year
      expect_str = "#{start_year}-#{Time.current.year}"
      expect(helper.copyright_years).to eq expect_str
    end
  end
end
