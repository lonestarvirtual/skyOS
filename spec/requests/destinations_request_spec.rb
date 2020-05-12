# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Destinations', type: :request do
  describe 'GET #index' do
    it 'assigns @flights' do
      flight = create(:flight)
      flight = [flight.orig.to_marker, flight.dest.to_marker]
      get destinations_path
      expect(assigns(:flights)).to eq [flight]
    end

    it 'renders the index template' do
      get destinations_path
      expect(response).to render_template('index')
    end
  end
end
