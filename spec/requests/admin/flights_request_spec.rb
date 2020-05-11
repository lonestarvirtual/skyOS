# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Flights', type: :request do
  login_admin

  describe 'GET #index' do
    it 'assigns @flights' do
      flights = create(:flight)
      get admin_flights_path
      expect(assigns(:flights)).to eq [flights]
    end

    it 'renders the index template' do
      get admin_flights_path
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @flight = build(:flight)
        @attributes = @flight.attributes

        @attributes[:orig_icao] = @flight.orig.icao
        @attributes[:dest_icao] = @flight.dest.icao
      end

      it 'creates the flight' do
        expect do
          post admin_flights_path, params: { flight: @attributes }
        end.to change(Flight, :count).by 1
      end

      it 'redirects to the index path' do
        post admin_flights_path, params: { flight: @attributes }
        expect(response).to redirect_to admin_flights_path
      end
    end

    context 'invalid attributes' do
      it 'renders the new template' do
        attributes = attributes_for(:flight, :invalid)
        post admin_flights_path, params: { flight: attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @flight = create(:flight)
    end

    it 'destroys the flight' do
      expect do
        delete admin_flight_path(@flight)
      end.to change(Flight, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_flight_path(@flight)
      expect(response).to redirect_to admin_flights_path
    end

    it 're-renders the edit page if the Flight cannot be deleted' do
      expect_any_instance_of(Flight).to receive(:destroy).and_return(false)
      delete admin_flight_path(@flight)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #edit' do
    before :each do
      @flight = create(:flight)
      get edit_admin_flight_path(@flight)
    end

    it 'assigns @flight' do
      expect(assigns(:flight)).to eq @flight
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #new' do
    before :each do
      get new_admin_flight_path
    end

    it 'assigns a new @flight' do
      expect(assigns(:flight).persisted?).to be_falsey
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'PUT #update' do
    before :each do
      @flight = create(:flight)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:flight)
        put admin_flight_path(@flight), params: { flight: @attributes }
      end

      it 'assigns the @flight' do
        expect(assigns(:flight)).to eq @flight
      end

      it 'changes the @flights attributes' do
        @flight.reload
        expect(@flight.number).to eq @attributes[:number]
      end

      it 'redirects to the admin_flights_path' do
        expect(response).to redirect_to admin_flights_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = attributes_for(:flight, :invalid)
        put admin_flight_path(@flight), params: { flight: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
