# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET #index' do
    before :all do
      Announcement.destroy_all
    end

    it 'assigns @announcement' do
      announcement = create(:announcement)
      get root_path
      expect(assigns(:announcement)).to eq announcement
    end

    it 'renders the index template' do
      get root_path
      expect(response).to render_template('index')
    end
  end
end
