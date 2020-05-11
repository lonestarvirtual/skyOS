# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pireps', type: :request do
  describe 'POST #create' do
    login_pilot

    context 'valid attributes' do
      before :each do
        @attributes = build(:pirep, :submitted).attributes
        @attributes[:orig_icao] = Airport.find(@attributes['orig_id']).icao
        @attributes[:dest_icao] = Airport.find(@attributes['dest_id']).icao
      end

      it 'creates the pirep' do
        expect do
          post pireps_path, params: { pirep: @attributes }
        end.to change(Pirep, :count).by 1
      end

      it 'redirects to the index path' do
        post pireps_path, params: { pirep: @attributes }
        expect(response).to redirect_to pilot_logbook_path(@current_pilot)
      end
    end

    context 'invalid attributes' do
      it 'renders the new template' do
        attributes = attributes_for(:pirep, :invalid)
        post pireps_path, params: { pirep: attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    login_pilot

    before :each do
      @pirep = create(:pirep, :draft, pilot: @current_pilot)
      get edit_pirep_path(@pirep)
    end

    it 'assigns @pirep' do
      expect(assigns(:pirep)).to eq @pirep
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #new' do
    login_pilot

    before :each do
      get new_pirep_path
    end

    it 'assigns a new @pirep' do
      expect(assigns(:pirep).persisted?).to be_falsey
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    before :each do
      @pirep = create(:pirep)
      get pirep_path(@pirep)
    end

    it 'assigns @pirep' do
      expect(assigns(:pirep)).to eq @pirep
    end

    it 'renders the show template' do
      expect(response).to render_template :show
    end
  end

  describe 'PUT #update' do
    login_pilot

    before :each do
      @pirep = create(:pirep, :draft, pilot: @current_pilot)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:pirep)
        put pirep_path(@pirep), params: { pirep: @attributes }
      end

      it 'assigns the @pirep' do
        expect(assigns(:pirep)).to eq @pirep
      end

      it 'changes the @pireps attributes' do
        @pirep.reload
        expect(@pirep.route).to eq @attributes[:route]
      end

      it 'redirects to the pilot_logbook_path' do
        expect(response).to redirect_to pilot_logbook_path(@current_pilot)
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = attributes_for(:pirep, :invalid)
        put pirep_path(@pirep), params: { pirep: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
