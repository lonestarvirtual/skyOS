# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Networks', type: :request do
  login_admin

  describe 'GET #index' do
    before :all do
      Network.destroy_all
    end

    it 'assigns @equipment' do
      network = create(:network)
      get admin_networks_path
      expect(assigns(:networks)).to eq [network]
    end

    it 'renders the index template' do
      get admin_networks_path
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @attributes = attributes_for :network
      end

      it 'creates the network' do
        expect do
          post admin_networks_path, params: { network: @attributes }
        end.to change(Network, :count).by 1
      end

      it 'redirects to the index path' do
        post admin_networks_path, params: { network: @attributes }
        expect(response).to redirect_to admin_networks_path
      end
    end

    context 'invalid attributes' do
      it 'renders the new template' do
        attributes = attributes_for(:network, :invalid)
        post admin_networks_path, params: { network: attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @network = create(:network)
    end

    it 'destroys the network' do
      expect do
        delete admin_network_path(@network)
      end.to change(Network, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_network_path(@network)
      expect(response).to redirect_to admin_networks_path
    end

    it 're-renders the edit page if the Network cannot be deleted' do
      expect_any_instance_of(Network).to receive(:destroy).and_return(false)
      delete admin_network_path(@network)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #edit' do
    before :each do
      @network = create(:network)
      get edit_admin_network_path(@network)
    end

    it 'assigns @network' do
      expect(assigns(:network)).to eq @network
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #new' do
    before :each do
      get new_admin_network_path
    end

    it 'assigns a new @network' do
      expect(assigns(:network).persisted?).to be_falsey
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'PUT #update' do
    before :each do
      @network = create(:network)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:equipment)
        put admin_network_path(@network), params: { network: @attributes }
      end

      it 'assigns the @network' do
        expect(assigns(:network)).to eq @network
      end

      it 'changes the @networks attributes' do
        @network.reload
        expect(@network.name).to eq @attributes[:name]
      end

      it 'redirects to the admin_networks_path' do
        expect(response).to redirect_to admin_networks_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = attributes_for(:network, :invalid)
        put admin_network_path(@network), params: { network: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
