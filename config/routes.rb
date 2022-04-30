# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'posts#top'
  get 'notifications/index'
  get 'users/show'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  resources :users, only: %i[show edit update]
  get '/mypage' => 'users#mypage'
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
  get '/votes' => 'posts#vote'
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
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    get '/:locale' => 'posts#index'
  end
end
