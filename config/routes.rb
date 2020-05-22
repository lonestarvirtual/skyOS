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
    resources :airlines,      except: [:show]
    resources :airports,      except: [:show]
    resources :announcements, except: [:show]
    resources :equipment,     except: [:show]
    resources :fleets,        except: [:show]
    resources :flights,       except: [:show]
    resources :networks,      except: [:show]
    resources :news,          except: [:show], as: :articles
    resources :pilots,        except: %i[show new create]
    resources :pireps,        except: %i[show new create]
    resources :settings,      only:   %i[index create]
    resources :simulators,    except: [:show]

    delete :announcements, controller: 'announcements', action: :purge
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

  resources :fleet, only: [:index]
  post '/fleet/download' => 'fleet#download'

  resources :flights, only: [:index]
  resources :notifications, only: [:destroy]
  resources :news, only: %i[index show], as: :articles

  resources :pilots, only: [:index] do
    resource :logbook, only: [:show]
  end

  resources :pireps, except: [:index]
  resources :policy, only: :show
  resources :pilots, only: [:index]
  resource  :profile, only: %i[edit update]
end
