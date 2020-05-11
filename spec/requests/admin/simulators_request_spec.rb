# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Simulators', type: :request do
  login_admin

  describe 'GET #index' do
    before :all do
      Simulator.destroy_all
    end

    it 'assigns @simulator' do
      simulator = create(:simulator)
      get admin_simulators_path
      expect(assigns(:simulators)).to eq [simulator]
    end

    it 'renders the index template' do
      get admin_simulators_path
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @attributes = attributes_for :simulator
      end

      it 'creates the simulator' do
        expect do
          post admin_simulators_path, params: { simulator: @attributes }
        end.to change(Simulator, :count).by 1
      end

      it 'redirects to the index path' do
        post admin_simulators_path, params: { simulator: @attributes }
        expect(response).to redirect_to admin_simulators_path
      end
    end

    context 'invalid attributes' do
      it 'renders the new template' do
        attributes = attributes_for(:simulator, :invalid)
        post admin_simulators_path, params: { simulator: attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @simulator = create(:simulator)
    end

    it 'destroys the simulator' do
      expect do
        delete admin_simulator_path(@simulator)
      end.to change(Simulator, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_simulator_path(@simulator)
      expect(response).to redirect_to admin_simulators_path
    end

    it 're-renders the edit page if the simulator cannot be deleted' do
      expect_any_instance_of(Simulator).to receive(:destroy).and_return(false)
      delete admin_simulator_path(@simulator)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #edit' do
    before :each do
      @simulator = create(:simulator)
      get edit_admin_simulator_path(@simulator)
    end

    it 'assigns @simulator' do
      expect(assigns(:simulator)).to eq @simulator
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #new' do
    before :each do
      get new_admin_simulator_path
    end

    it 'assigns a new @simulator' do
      expect(assigns(:simulator).persisted?).to be_falsey
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'PUT #update' do
    before :each do
      @simulator = create(:simulator)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:simulator)
        put admin_simulator_path(@simulator), params: { simulator: @attributes }
      end

      it 'assigns the @simulator' do
        expect(assigns(:simulator)).to eq @simulator
      end

      it 'changes the @simulators attributes' do
        @simulator.reload
        expect(@simulator.short_name).to eq @attributes[:short_name]
      end

      it 'redirects to the admin_simulators_path' do
        expect(response).to redirect_to admin_simulators_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = attributes_for(:simulator, :invalid)
        put admin_simulator_path(@simulator), params: { simulator: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
