Rails.application.routes.draw do
  
  get 'users/show'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    :sessions => "users/sessions" ,
    :registrations => "users/registrations"
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


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
 
end
