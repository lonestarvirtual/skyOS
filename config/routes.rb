# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :pilots,
             controllers: {
               registrations: 'registrations'
             },
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             },
             skip: :registrations

  devise_scope :pilot do
    resource :registrations,
             only: %i[new create],
             path: '',
             path_names: { new: 'join' },
             as: :pilot_registration
  end

  root to: 'home#index'

  namespace :admin do
    resources :airlines,   except: [:show]
    resources :airports,   except: [:show]
    resources :equipment,  except: [:show]
    resources :fleets,     except: [:show]
    resources :flights,    except: [:show]
    resources :networks,   except: [:show]
    resources :pilots,     except: %i[show new create]
    resources :pireps,     except: %i[show new create]
    resources :simulators, except: [:show]
  end

  namespace :api do
    namespace :v1 do
      resources :airports, only: [:show]
    end
  end

  resource  :contact, only: [:create], as: :contact do
    get '/' => 'contacts#new'
  end

  resources :destinations, only: [:index]
  resources :fleet
  resources :flights, only: [:index]

  resources :pilots, only: [:index] do
    resource :logbook, only: [:show]
  end

  resources :pireps, except: [:index]
  resources :policy, only: :show
  resources :pilots, only: [:index]
  resource  :profile, only: %i[edit update]
end
