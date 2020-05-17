# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'News', type: :request do
  describe 'GET #index' do
    it 'assigns @articles' do
      article = create(:article)
      get articles_path
      expect(assigns(:articles)).not_to be_nil
    end

    it 'renders the index template' do
      get articles_path
      expect(response).to render_template('index')
    end
  end
end
