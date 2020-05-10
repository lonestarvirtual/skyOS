# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Fleets', type: :request do
  describe 'GET #index' do
    it 'assigns @fleet' do
      fleet = create(:fleet)
      get fleet_index_path
      expect(assigns(:fleet)).to eq [fleet]
    end

    it 'renders the index template' do
      get fleet_index_path
      expect(response).to render_template('index')
    end
  end
end
