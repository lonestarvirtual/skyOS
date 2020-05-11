# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @attributes = attributes_for :contact
      end

      it 'assigns a @contact' do
        post contact_path, params: { contact: @attributes }
        expect(assigns(:contact).first_name).to eq @attributes[:first_name]
      end

      it 'calls the contact mailer' do
        message_delivery = instance_double(ActionMailer::MessageDelivery)
        expect(ContactMailer).to receive(:contact_email).and_return(message_delivery)
        allow(message_delivery).to receive(:deliver_now)
        post contact_path, params: { contact: @attributes }
      end

      it 'redirects to the root path' do
        post contact_path, params: { contact: @attributes }
        expect(response).to redirect_to root_path
      end
    end

    context 'invalid attributes' do
      it 'renders the new template' do
        attributes = attributes_for(:contact, :invalid)
        post contact_path, params: { contact: attributes }
        expect(response).to render_template :new
      end
    end

    context 'pilot signed in' do
      login_pilot

      before :each do
        attributes = { message: 'test message' }
        post contact_path, params: { contact: attributes }
      end

      it 'enforces the contact attributes' do
        expect(assigns(:contact).first_name).to eq @current_pilot.first_name
        expect(assigns(:contact).last_name).to eq @current_pilot.last_name
        expect(assigns(:contact).email).to eq @current_pilot.email
      end
    end
  end

  describe 'GET #new' do
    before :each do
      get contact_path
    end

    it 'assigns a new @contact' do
      expect(assigns(:contact).class).to eq Contact
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end

    context 'visitor' do
      it 'does not pre-populate name and email fields' do
        expect(assigns(:contact).first_name).to be_nil
        expect(assigns(:contact).last_name).to be_nil
        expect(assigns(:contact).email).to be_nil
      end
    end

    context 'signed in pilot' do
      login_pilot

      before :each do
        get contact_path
      end

      it 'pre-populates the name and email fields' do
        expect(assigns(:contact).first_name).to eq @current_pilot.first_name
        expect(assigns(:contact).last_name).to eq @current_pilot.last_name
        expect(assigns(:contact).email).to eq @current_pilot.email
      end
    end
  end
end
