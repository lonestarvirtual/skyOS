# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Pilots', type: :request do
  login_admin

  describe 'GET #index' do
    before :each do
      Pilot.destroy_all
    end

    it 'assigns @pilots' do
      pilot = create(:pilot)
      get admin_pilots_path
      expect(assigns(:pilots)).to eq [pilot]
    end

    it 'renders the index template' do
      get admin_pilots_path
      expect(response).to render_template('index')
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @pilot = create(:pilot)
    end

    it 'destroys the pilot' do
      expect do
        delete admin_pilot_path(@pilot)
      end.to change(Pilot, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_pilot_path(@pilot)
      expect(response).to redirect_to admin_pilots_path
    end

    it 're-renders the edit page if the Pilot cannot be deleted' do
      expect_any_instance_of(Pilot).to receive(:destroy).and_return(false)
      delete admin_pilot_path(@pilot)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #edit' do
    before :each do
      @pilot = create(:pilot)
      get edit_admin_pilot_path(@pilot)
    end

    it 'assigns @pilot' do
      expect(assigns(:pilot)).to eq @pilot
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    before :each do
      @pilot = create(:pilot)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:pilot)
        put admin_pilot_path(@pilot), params: { pilot: @attributes }
      end

      it 'assigns the @pilot' do
        expect(assigns(:pilot)).to eq @pilot
      end

      it 'changes the @pilots attributes' do
        @pilot.reload
        expect(@pilot.first_name).to eq @attributes[:first_name]
      end

      it 'redirects to the admin_pilots_path' do
        expect(response).to redirect_to admin_pilots_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = attributes_for(:pilot, :invalid)
        put admin_pilot_path(@pilot), params: { pilot: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
