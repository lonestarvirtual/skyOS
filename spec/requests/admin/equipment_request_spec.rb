# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Equipment', type: :request do
  login_admin

  describe 'GET #index' do
    before :all do
      Equipment.destroy_all
    end

    it 'assigns @equipment' do
      equipment = create(:equipment)
      get admin_equipment_index_path
      expect(assigns(:equipment)).to eq [equipment]
    end

    it 'renders the index template' do
      get admin_equipment_index_path
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @attributes = attributes_for :equipment
      end

      it 'creates the equipment' do
        expect do
          post admin_equipment_index_path, params: { equipment: @attributes }
        end.to change(Equipment, :count).by 1
      end

      it 'redirects to the index path' do
        post admin_equipment_index_path, params: { equipment: @attributes }
        expect(response).to redirect_to admin_equipment_index_path
      end
    end

    context 'invalid attributes' do
      it 'renders the new template' do
        attributes = attributes_for(:equipment, :invalid)
        post admin_equipment_index_path, params: { equipment: attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @equipment = create(:equipment)
    end

    it 'destroys the equipment' do
      expect do
        delete admin_equipment_path(@equipment)
      end.to change(Equipment, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_equipment_path(@equipment)
      expect(response).to redirect_to admin_equipment_index_path
    end

    it 're-renders the edit page if the Equipment cannot be deleted' do
      expect_any_instance_of(Equipment).to receive(:destroy).and_return(false)
      delete admin_equipment_path(@equipment)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #edit' do
    before :each do
      @equipment = create(:equipment)
      get edit_admin_equipment_path(@equipment)
    end

    it 'assigns @equipment' do
      expect(assigns(:equipment)).to eq @equipment
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #new' do
    before :each do
      get new_admin_equipment_path
    end

    it 'assigns a new @equipment' do
      expect(assigns(:equipment).persisted?).to be_falsey
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'PUT #update' do
    before :each do
      @equipment = create(:equipment)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:equipment)
        put admin_equipment_path(@equipment), params: { equipment: @attributes }
      end

      it 'assigns the @equipment' do
        expect(assigns(:equipment)).to eq @equipment
      end

      it 'changes the @equipments attributes' do
        @equipment.reload
        expect(@equipment.short_name).to eq @attributes[:short_name]
      end

      it 'redirects to the admin_equipment_index_path' do
        expect(response).to redirect_to admin_equipment_index_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = attributes_for(:equipment, :invalid)
        put admin_equipment_path(@equipment), params: { equipment: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
