# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Pireps', type: :request do
  login_admin

  describe 'GET #index' do
    it 'assigns @pireps' do
      pirep = create(:pirep, :submitted)
      get admin_pireps_path
      expect(assigns(:pireps)).to eq [pirep]
    end

    it 'renders the index template' do
      get admin_pireps_path
      expect(response).to render_template('index')
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @pirep = create(:pirep)
    end

    it 'destroys the PIREP' do
      expect do
        delete admin_pirep_path(@pirep)
      end.to change(Pirep, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_pirep_path(@pirep)
      expect(response).to redirect_to admin_pireps_path
    end

    it 're-renders the edit page if the PIREP cannot be deleted' do
      expect_any_instance_of(Pirep).to receive(:destroy).and_return(false)
      delete admin_pirep_path(@pirep)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #edit' do
    before :each do
      @pirep = create(:pirep)
      get edit_admin_pirep_path(@pirep)
    end

    it 'assigns @pirep' do
      expect(assigns(:pirep)).to eq @pirep
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    before :each do
      @pirep = create(:pirep)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:pirep)
        put admin_pirep_path(@pirep), params: { pirep: @attributes }
      end

      it 'assigns the @pirep' do
        expect(assigns(:pirep)).to eq @pirep
      end

      it 'changes the @pireps attributes' do
        @pirep.reload
        expect(@pirep.duration.to_s).to eq @attributes[:duration].to_s
      end

      it 'redirects to the admin_pireps_path' do
        expect(response).to redirect_to admin_pireps_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = attributes_for(:pirep, :invalid)
        put admin_pirep_path(@pirep), params: { pirep: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
