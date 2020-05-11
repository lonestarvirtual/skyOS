# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Settings', type: :request do
  login_admin

  describe 'GET #index' do
    it 'renders the index template' do
      get admin_settings_path
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @attributes = { organization_icao: 'TEST' }
        post admin_settings_path, params: { setting: @attributes }
      end

      it 'updates the Setting' do
        expect(Setting.organization_icao).to eq @attributes[:organization_icao]
      end

      it 'redirects to the index path' do
        expect(response).to redirect_to admin_settings_path
      end
    end
  end
end
