Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    root 'posts#index'
     devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    }
    resources :users, only: %i[mypage show edit update]
     
    resources :posts do
    resources :comments
    end
    resources :posts do
      collection do
        post :confirm
       end
       member do
        post :vote_up
       end
    end
    get '/vote' => 'posts#vote'
    get '/top' => 'posts#top'
    resources :stocks, only: %i[create destroy]
    resources :users, only: [:show] do
    get :stocks, on: :member
    end
    resources :conversations do
        resources :messages
    end
  # resources :notifications, only: :index
    post '/guests/guest_sign_in', to: 'guests#new_guest'
    post '/guests/admin_guest_sign_in', to: 'guests#new_admin_guest'
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
 
 
end
