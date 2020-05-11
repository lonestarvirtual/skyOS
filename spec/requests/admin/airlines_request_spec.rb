# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Airlines', type: :request do
  login_admin

  describe 'GET #index' do
    it 'assigns @airlines' do
      airline = create(:airline)
      get admin_airlines_path
      expect(assigns(:airlines)).to eq [airline]
    end

    it 'renders the index template' do
      get admin_airlines_path
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @attributes = attributes_for :airline
      end

      it 'creates the airline' do
        expect do
          post admin_airlines_path, params: { airline: @attributes }
        end.to change(Airline, :count).by 1
      end

      it 'redirects to the index path' do
        post admin_airlines_path, params: { airline: @attributes }
        expect(response).to redirect_to admin_airlines_path
      end
    end

    context 'invalid attributes' do
      it 'renders the new template' do
        attributes = attributes_for(:airline, :invalid)
        post admin_airlines_path, params: { airline: attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @airline = create(:airline)
    end

    it 'destroys the airline' do
      expect do
        delete admin_airline_path(@airline)
      end.to change(Airline, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_airline_path(@airline)
      expect(response).to redirect_to admin_airlines_path
    end

    it 're-renders the edit page if the Airline cannot be deleted' do
      expect_any_instance_of(Airline).to receive(:destroy).and_return(false)
      delete admin_airline_path(@airline)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #edit' do
    before :each do
      @airline = create(:airline)
      get edit_admin_airline_path(@airline)
    end

    it 'assigns @airline' do
      expect(assigns(:airline)).to eq @airline
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #new' do
    before :each do
      get new_admin_airline_path
    end

    it 'assigns a new @airline' do
      expect(assigns(:airline).persisted?).to be_falsey
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'PUT #update' do
    before :each do
      @airline = create(:airline)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:airline)
        put admin_airline_path(@airline), params: { airline: @attributes }
      end

      it 'assigns the @airline' do
        expect(assigns(:airline)).to eq @airline
      end

      it 'changes the @airlines attributes' do
        @airline.reload
        expect(@airline.name).to eq @attributes[:name]
      end

      it 'redirects to the admin_airlines_path' do
        expect(response).to redirect_to admin_airlines_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = attributes_for(:airline, :invalid)
        put admin_airline_path(@airline), params: { airline: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
