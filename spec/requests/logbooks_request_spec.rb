# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logbooks', type: :request do
  describe 'GET #show' do
    before :each do
      @pirep = create(:pirep, :approved)
      @pilot = @pirep.pilot
      get pilot_logbook_path(@pilot)
    end

    it 'assigns @pilot' do
      expect(assigns(:pilot)).to eq @pilot
    end

    it 'assigns @pireps' do
      expect(assigns(:pireps)).to eq [@pirep]
    end

    it 'renders the show template' do
      expect(response).to render_template :show
    end
  end
end
