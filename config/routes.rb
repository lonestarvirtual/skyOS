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

  namespace :admin do
    resources :airlines,  except: [:show]
    resources :airports,  except: [:show]
    resources :equipment, except: [:show]
    resources :fleets,    except: [:show]
  end

  resource  :contact, only: [:create], as: :contact do
    get '/' => 'contacts#new'
  end

  resources :policy, only: :show

  resources :fleet
end
