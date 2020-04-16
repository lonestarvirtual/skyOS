# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :pilots,
             controllers: {
               registrations: 'registrations'
             },
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'join'
             }
  root to: 'home#index'

  resources :policy, only: :show
end
