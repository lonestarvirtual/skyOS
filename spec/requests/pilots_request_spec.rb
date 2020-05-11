# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pilots', type: :request do
  describe 'GET #index' do
    it 'assigns @pilots' do
      pilot = create(:pilot, :confirmed, active: true)
      get pilots_path
      expect(assigns(:pilots)).to eq [pilot]
    end

    it 'renders the index template' do
      get pilots_path
      expect(response).to render_template('index')
    end
  end
end
