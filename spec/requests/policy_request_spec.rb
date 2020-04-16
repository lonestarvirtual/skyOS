# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Policies', type: :request do
  describe 'GET Privacy Policy' do
    it 'renders the privacy policy view' do
      get policy_path('privacy')
      expect(response).to render_template 'privacy'
    end
  end

  describe 'GET Terms of Use' do
    it 'renders the terms policy view' do
      get policy_path('terms')
      expect(response).to render_template 'terms'
    end
  end
end
