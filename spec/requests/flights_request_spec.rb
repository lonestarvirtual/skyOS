# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Flights', type: :request do
  login_pilot

  describe 'GET #index' do
    it 'assigns @flights' do
      flight = create(:flight)
      get flights_path
      expect(assigns(:flights)).to eq [flight]
    end

    it 'renders the index template' do
      get flights_path
      expect(response).to render_template('index')
    end
  end
end
