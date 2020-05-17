# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::News', type: :request do
  login_admin

  describe 'GET #index' do
    before :all do
      Article.destroy_all
    end

    it 'assigns @articles' do
      article = create(:article)
      get admin_articles_path
      expect(assigns(:articles)).to eq [article]
    end

    it 'renders the index template' do
      get admin_articles_path
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @attributes = attributes_for :article
      end

      it 'creates the article' do
        expect do
          post admin_articles_path, params: { article: @attributes }
        end.to change(Article, :count).by 1
      end

      it 'redirects to the index path' do
        post admin_articles_path, params: { article: @attributes }
        expect(response).to redirect_to admin_articles_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @article = create(:article)
    end

    it 'destroys the equipment' do
      expect do
        delete admin_article_path(@article)
      end.to change(Article, :count).by(-1)
    end

    it 'redirects to the index path' do
      delete admin_article_path(@article)
      expect(response).to redirect_to admin_articles_path
    end

    it 're-renders the edit page if the Article cannot be deleted' do
      expect_any_instance_of(Article).to receive(:destroy).and_return(false)
      delete admin_article_path(@article)
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
      get new_admin_article_path
    end

    it 'assigns a new @article' do
      expect(assigns(:article).persisted?).to be_falsey
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'PUT #update' do
    before :each do
      @article = create(:article)
    end

    context 'with valid attributes' do
      before :each do
        @attributes = attributes_for(:article)
        put admin_article_path(@article), params: { article: @attributes }
      end

      it 'assigns the @article' do
        expect(assigns(:article)).to eq @article
      end

      it 'changes the @articles attributes' do
        @article.reload
        expect(@article.title).to eq @attributes[:title]
      end

      it 'redirects to the admin_articles_path' do
        expect(response).to redirect_to admin_articles_path
      end
    end
  end
end
