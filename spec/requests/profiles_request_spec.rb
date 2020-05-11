# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  login_pilot

  describe 'GET #edit' do
    before :each do
      get edit_profile_path
    end

    it 'assigns @pilot' do
      expect(assigns(:pilot)).to eq @current_pilot
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      before :each do
        @attributes = { time_zone: 'America/Bogota' }
        put profile_path, params: { pilot: @attributes }
      end

      it 'assigns the @pilot' do
        expect(assigns(:pilot)).to eq @current_pilot
      end

      it 'changes the @pilots attributes' do
        @current_pilot.reload
        expect(@current_pilot.time_zone).to eq @attributes[:time_zone]
      end

      it 'redirects to the edit_profile_path' do
        expect(response).to redirect_to edit_profile_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = { email: nil }
        put profile_path, params: { pilot: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
