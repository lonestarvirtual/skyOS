# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Airports', type: :request do
  login_admin

  describe 'GET #index' do
    it 'assigns @airports' do
      airports = create(:airport)
      get admin_airports_path
      expect(assigns(:airports)).to eq [airports]
    end

    it 'renders the index template' do
      get admin_airports_path
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @attributes = attributes_for :airport
      end

      it 'creates the airport' do
        expect do
          post admin_airports_path, params: { airport: @attributes }
        end.to change(Airport, :count).by 1
      end

      it 'redirects to the index path' do
        post admin_airports_path, params: { airport: @attributes }
        expect(response).to redirect_to admin_airports_path
      end
    end

    context 'invalid attributes' do
      it 'renders the new template' do
        attributes = attributes_for(:airport, :invalid)
        post admin_airports_path, params: { airport: attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @airport = create(:airport)
    end

    it 'destroys the airport' do
      expect do
        delete admin_airport_path(@airport)
      end.to change(Airport, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_airport_path(@airport)
      expect(response).to redirect_to admin_airports_path
    end

    it 're-renders the edit page if the Airport cannot be deleted' do
      expect_any_instance_of(Airport).to receive(:destroy).and_return(false)
      delete admin_airport_path(@airport)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #edit' do
    before :each do
      @airport = create(:airport)
      get edit_admin_airport_path(@airport)
    end

    it 'assigns @airport' do
      expect(assigns(:airport)).to eq @airport
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #new' do
    before :each do
      get new_admin_airport_path
    end

    it 'assigns a new @airport' do
      expect(assigns(:airport).persisted?).to be_falsey
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'PUT #update' do
    before :each do
      @airport = create(:airport)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:airport)
        put admin_airport_path(@airport), params: { airport: @attributes }
      end

      it 'assigns the @airport' do
        expect(assigns(:airport)).to eq @airport
      end

      it 'changes the @airports attributes' do
        @airport.reload
        expect(@airport.icao).to eq @attributes[:icao]
      end

      it 'redirects to the admin_airports_path' do
        expect(response).to redirect_to admin_airports_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = attributes_for(:airport, :invalid)
        put admin_airport_path(@airport), params: { airport: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
