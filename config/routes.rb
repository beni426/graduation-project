Rails.application.routes.draw do
  
  get 'users/show'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    :sessions => "users/sessions" ,
    :registrations => "users/registrations",
    :passwords =>'users/passwords'
    }
  resources :users,only: %i[show edit update]
  get '/mypage' => 'users#mypage'
  root to: "posts#index"
  resources :posts do
    resources :comments
  end
  resources :posts do
    collection do
      post :confirm
    end
  end
  get '/vote' => 'posts#vote'
  get '/top' =>'posts#top'
  resources :stocks, only: [:create, :destroy]
  resources :users, only: [:show] do 
    get :stocks, on: :member
  end
  resources :conversations do
    resources :messages
  end
  post '/guests/guest_sign_in', to: 'guests#new_guest'
  post '/guests/admin_guest_sign_in', to: 'guests#new_admin_guest'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
 
end
