# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Announcements', type: :request do
  login_admin

  describe 'GET #index' do
    before :all do
      Announcement.destroy_all
    end

    it 'assigns @announcements' do
      announcements = create(:announcement)
      get admin_announcements_path
      expect(assigns(:announcements)).to eq [announcements]
    end

    it 'renders the index template' do
      get admin_announcements_path
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @attributes = attributes_for :announcement
      end

      it 'creates the announcement' do
        expect do
          post admin_announcements_path, params: { announcement: @attributes }
        end.to change(Announcement, :count).by 1
      end

      it 'redirects to the index path' do
        post admin_announcements_path, params: { announcement: @attributes }
        expect(response).to redirect_to admin_announcements_path
      end
    end

    context 'invalid attributes' do
      it 'renders the new template' do
        attributes = attributes_for(:announcement, :invalid)
        post admin_announcements_path, params: { announcement: attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @announcement = create(:announcement)
    end

    it 'destroys the announcement' do
      expect do
        delete admin_announcement_path(@announcement)
      end.to change(Announcement, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_announcement_path(@announcement)
      expect(response).to redirect_to admin_announcements_path
    end

    it 're-renders the edit page if the announcement cannot be deleted' do
      expect_any_instance_of(Announcement).to receive(:destroy).and_return(false)
      delete admin_announcement_path(@announcement)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #edit' do
    before :each do
      @announcement = create(:announcement)
      get edit_admin_announcement_path(@announcement)
    end

    it 'assigns @announcement' do
      expect(assigns(:announcement)).to eq @announcement
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #new' do
    before :each do
      get new_admin_announcement_path
    end

    it 'assigns a new @announcement' do
      expect(assigns(:announcement).persisted?).to be_falsey
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'DELETE #purge' do
    before :each do
      end_time = Time.current - 1.day
      create_list(:announcement, 4, :skip_validation, end_at: end_time)
    end

    it 'purges announcements that are not longer visible' do
      expect do
        delete admin_announcements_path
      end.to change(Announcement, :count).by(-4)
    end

    it 'redirects to the index page' do
      delete admin_announcements_path
      expect(response).to redirect_to admin_announcements_path
    end

    it 'redirects the index page if the announcements cannot be purged' do
      expect(Announcement).to receive(:purge).and_return(false)
      delete admin_announcements_path
      expect(response).to redirect_to admin_announcements_path
    end
  end

  describe 'PUT #update' do
    before :each do
      @announcement = create(:announcement)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:announcement)
        put admin_announcement_path(@announcement), params: { announcement: @attributes }
      end

      it 'assigns the @announcement' do
        expect(assigns(:announcement)).to eq @announcement
      end

      it 'changes the @announcements attributes' do
        @announcement.reload
        expect(@announcement.title).to eq @attributes[:title]
      end

      it 'redirects to the admin_announcements_path' do
        expect(response).to redirect_to admin_announcements_path
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        attributes = attributes_for(:announcement, :invalid)
        put admin_announcement_path(@announcement), params: { announcement: attributes }
        expect(response).to render_template :edit
      end
    end
  end
end
