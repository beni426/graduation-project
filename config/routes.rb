Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    :sessions => "users/sessions" ,
    :registrations => "users/registrations"
    
    }
 
 

  root to: "posts#index"
  resources :posts do
    resources :comments
  end
  resources :posts do
    collection do
      post :confirm
    end
  end


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
 
end
