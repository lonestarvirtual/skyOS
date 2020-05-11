# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Fleets', type: :request do
  login_admin

  describe 'GET #index' do
    it 'assigns @fleet' do
      fleet = create(:fleet)
      get admin_fleets_path
      expect(assigns(:fleets)).to eq [fleet]
    end

    it 'renders the index template' do
      get admin_fleets_path
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @attributes = { airline_id: create(:airline).id,
                        equipment_id: create(:equipment).id }
      end

      it 'creates the fleet' do
        expect do
          post admin_fleets_path, params: { fleet: @attributes }
        end.to change(Fleet, :count).by 1
      end

      it 'redirects to the index path' do
        post admin_fleets_path, params: { fleet: @attributes }
        expect(response).to redirect_to admin_fleets_path
      end
    end

    context 'invalid attributes' do
      it 'renders the new template' do
        attributes = build(:fleet).attributes
        attributes[:airline_id] = nil
        post admin_fleets_path, params: { fleet: attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @fleet = create(:fleet)
    end

    it 'destroys the fleet' do
      expect do
        delete admin_fleet_path(@fleet)
      end.to change(Fleet, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_fleet_path(@fleet)
      expect(response).to redirect_to admin_fleets_path
    end

    it 're-renders the edit page if the fleet cannot be deleted' do
      expect_any_instance_of(Fleet).to receive(:destroy).and_return(false)
      delete admin_fleet_path(@fleet)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #edit' do
    before :each do
      @fleet = create(:fleet)
      get edit_admin_fleet_path(@fleet)
    end

    it 'assigns @fleet' do
      expect(assigns(:fleet)).to eq @fleet
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #new' do
    before :each do
      get new_admin_fleet_path
    end

    it 'assigns a new @fleet' do
      expect(assigns(:fleet).persisted?).to be_falsey
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'PUT #update' do
    before :each do
      @fleet = create(:fleet)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = { airline_id: create(:airline).id,
                        equipment_id: create(:equipment).id }
        put admin_fleet_path(@fleet), params: { fleet: @attributes }
      end

      it 'assigns the @fleet' do
        expect(assigns(:fleet)).to eq @fleet
      end

      it 'changes the @fleets attributes' do
        @fleet.reload
        expect(@fleet.airline.id).to eq @attributes[:airline_id]
      end

      it 'redirects to the admin_fleets_path' do
        expect(response).to redirect_to admin_fleets_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = create(:fleet).attributes
        attributes[:airline_id] = nil
        put admin_fleet_path(@fleet), params: { fleet: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
