# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Airports', type: :request do
  login_pilot

  describe 'GET #show' do
    context 'with an airport ICAO in the database' do
      before :each do
        @airport = create(:airport)
        get api_v1_airport_path(@airport)
      end

      it 'assigns the @airport' do
        expect(assigns(:airport)).to eq @airport
      end

      it 'renders the @airport as JSON' do
        expect(response.body).to eq @airport.to_json
      end
    end

    context 'with an airport ICAO that does not exist' do
      before :each do
        get api_v1_airport_path('XXXXXXX')
      end

      it 'assigns @airport as nil' do
        expect(assigns(:airport)).to be_nil
      end

      it 'renders an empty JSON object' do
        expect(response.body).to eq nil.to_json
      end
    end
  end
end
